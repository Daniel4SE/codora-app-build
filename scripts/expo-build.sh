#!/bin/bash
# Expo Build & Deploy Script
# Usage: expo-build.sh [project_dir] [platform] [action]
# Platform: android, ios, all, preview
# Action: build, submit, both, preview, update

set -e

PROJECT_DIR="${1:-.}"
PLATFORM="${2:-all}"
ACTION="${3:-build}"
OUTPUT_DIR="$HOME/Desktop"
DEFAULT_PORT=8081

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Find available port starting from DEFAULT_PORT
find_available_port() {
    local port=$DEFAULT_PORT
    local max_port=$((DEFAULT_PORT + 100))

    while [ $port -lt $max_port ]; do
        if ! lsof -i :$port > /dev/null 2>&1; then
            echo $port
            return 0
        fi
        port=$((port + 1))
    done

    echo $DEFAULT_PORT
    return 1
}

# Kill existing Expo process on port
kill_expo_on_port() {
    local port=$1
    local pid=$(lsof -ti :$port 2>/dev/null)

    if [ -n "$pid" ]; then
        log_warning "Found existing process on port $port (PID: $pid)"
        read -p "Kill existing process? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            kill -9 $pid 2>/dev/null || true
            sleep 1
            log_success "Killed process $pid"
            return 0
        fi
        return 1
    fi
    return 0
}

# Start Expo preview with auto port switching
start_preview() {
    local platform_arg=""

    case "$PLATFORM" in
        ios)
            platform_arg="--ios"
            ;;
        android)
            platform_arg="--android"
            ;;
        web)
            platform_arg="--web"
            ;;
    esac

    cd "$PROJECT_DIR"

    # Check if default port is in use
    if lsof -i :$DEFAULT_PORT > /dev/null 2>&1; then
        log_warning "Port $DEFAULT_PORT is already in use"

        # Try to find available port
        AVAILABLE_PORT=$(find_available_port)

        if [ "$AVAILABLE_PORT" != "$DEFAULT_PORT" ]; then
            log_info "Using alternative port: $AVAILABLE_PORT"
            npx expo start --port $AVAILABLE_PORT $platform_arg
        else
            # Ask user what to do
            log_warning "No available port found in range $DEFAULT_PORT-$((DEFAULT_PORT + 100))"
            echo ""
            echo "Options:"
            echo "  1) Kill existing Expo process and restart"
            echo "  2) Connect to existing server"
            echo "  3) Cancel"
            echo ""
            read -p "Choose [1/2/3]: " -n 1 -r choice
            echo

            case $choice in
                1)
                    kill_expo_on_port $DEFAULT_PORT
                    sleep 2
                    npx expo start --port $DEFAULT_PORT $platform_arg
                    ;;
                2)
                    log_info "Existing Expo server is running on port $DEFAULT_PORT"
                    log_info "Open Expo Go app and scan QR code, or press keys in that terminal:"
                    echo "  - Press 'i' for iOS simulator"
                    echo "  - Press 'a' for Android emulator"
                    echo "  - Press 'w' for web browser"
                    ;;
                *)
                    log_info "Cancelled"
                    exit 0
                    ;;
            esac
        fi
    else
        log_info "Starting Expo on port $DEFAULT_PORT..."
        npx expo start --port $DEFAULT_PORT $platform_arg
    fi
}

# OTA Update
push_update() {
    local message="${1:-OTA update}"

    cd "$PROJECT_DIR"

    log_info "Publishing OTA update..."
    eas update --branch production --message "$message" --non-interactive

    log_success "Update published!"
}

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."

    # Check EAS CLI
    if ! command -v eas &> /dev/null; then
        log_warning "EAS CLI not found. Installing..."
        npm install -g eas-cli
    fi

    # Check login status
    if ! eas whoami &> /dev/null; then
        log_error "Not logged in to EAS. Please run: eas login"
        exit 1
    fi

    log_success "Prerequisites OK. Logged in as: $(eas whoami)"
}

# Build Android APK
build_android() {
    log_info "Building Android APK..."

    cd "$PROJECT_DIR"

    # Start build
    BUILD_OUTPUT=$(eas build --platform android --profile preview 2>&1)

    # Extract build ID
    BUILD_ID=$(echo "$BUILD_OUTPUT" | grep -oE '[a-f0-9-]{36}' | head -1)

    if [ -z "$BUILD_ID" ]; then
        log_error "Failed to start Android build"
        echo "$BUILD_OUTPUT"
        return 1
    fi

    log_info "Build started: $BUILD_ID"
    log_info "Waiting for build to complete..."

    # Wait for build
    wait_for_build "$BUILD_ID" "android"
}

# Build iOS
build_ios() {
    log_info "Building iOS..."

    cd "$PROJECT_DIR"

    # Start build
    BUILD_OUTPUT=$(eas build --platform ios --profile production 2>&1)

    # Extract build ID
    BUILD_ID=$(echo "$BUILD_OUTPUT" | grep -oE '[a-f0-9-]{36}' | head -1)

    if [ -z "$BUILD_ID" ]; then
        log_error "Failed to start iOS build"
        echo "$BUILD_OUTPUT"
        return 1
    fi

    log_info "Build started: $BUILD_ID"
    log_info "Waiting for build to complete..."

    # Wait for build
    wait_for_build "$BUILD_ID" "ios"
}

# Wait for build to complete
wait_for_build() {
    local BUILD_ID=$1
    local PLATFORM=$2
    local MAX_WAIT=1800  # 30 minutes
    local WAITED=0

    while [ $WAITED -lt $MAX_WAIT ]; do
        BUILD_INFO=$(eas build:view "$BUILD_ID" 2>&1)
        STATUS=$(echo "$BUILD_INFO" | grep "Status" | head -1 | awk '{print $2}')

        if [ "$STATUS" = "finished" ]; then
            log_success "Build completed!"

            # Get download URL
            DOWNLOAD_URL=$(echo "$BUILD_INFO" | grep "Application Archive URL" | awk '{print $4}')

            if [ -n "$DOWNLOAD_URL" ] && [ "$DOWNLOAD_URL" != "null" ]; then
                log_info "Download URL: $DOWNLOAD_URL"

                # Download artifact
                if [ "$PLATFORM" = "android" ]; then
                    OUTPUT_FILE="$OUTPUT_DIR/$(basename "$PROJECT_DIR").apk"
                else
                    OUTPUT_FILE="$OUTPUT_DIR/$(basename "$PROJECT_DIR").ipa"
                fi

                log_info "Downloading to: $OUTPUT_FILE"
                curl -L -o "$OUTPUT_FILE" "$DOWNLOAD_URL"
                log_success "Downloaded: $OUTPUT_FILE"

                echo ""
                echo "=================================="
                echo "BUILD SUMMARY"
                echo "=================================="
                echo "Platform: $PLATFORM"
                echo "Build ID: $BUILD_ID"
                echo "Download URL: $DOWNLOAD_URL"
                echo "Local File: $OUTPUT_FILE"
                echo "=================================="
            fi

            return 0
        elif [ "$STATUS" = "errored" ]; then
            log_error "Build failed!"
            echo "$BUILD_INFO"
            return 1
        fi

        log_info "Status: $STATUS (waited ${WAITED}s)"
        sleep 30
        WAITED=$((WAITED + 30))
    done

    log_error "Build timed out after ${MAX_WAIT}s"
    return 1
}

# Submit to App Store
submit_ios() {
    log_info "Submitting iOS to App Store Connect..."

    cd "$PROJECT_DIR"

    # Get latest iOS build
    BUILD_INFO=$(eas build:list --platform ios --limit 1 2>&1)
    BUILD_ID=$(echo "$BUILD_INFO" | grep "ID" | head -1 | awk '{print $2}')

    if [ -z "$BUILD_ID" ]; then
        log_error "No iOS build found. Please build first."
        return 1
    fi

    # Get IPA URL
    FULL_INFO=$(eas build:view "$BUILD_ID" 2>&1)
    IPA_URL=$(echo "$FULL_INFO" | grep "Application Archive URL" | awk '{print $4}')

    if [ -z "$IPA_URL" ] || [ "$IPA_URL" = "null" ]; then
        log_error "No IPA URL found for build $BUILD_ID"
        return 1
    fi

    log_info "Submitting IPA: $IPA_URL"
    eas submit --platform ios --url "$IPA_URL"
}

# Submit to Google Play
submit_android() {
    log_info "Submitting Android to Google Play..."

    cd "$PROJECT_DIR"

    # Need AAB for Google Play, rebuild if necessary
    log_warning "Google Play requires AAB format. Building production version..."
    eas build --platform android --profile production

    # Then submit
    eas submit --platform android
}

# Main
main() {
    echo ""
    echo "=========================================="
    echo "  Expo Build & Deploy Tool"
    echo "=========================================="
    echo "Project: $PROJECT_DIR"
    echo "Platform: $PLATFORM"
    echo "Action: $ACTION"
    echo "=========================================="
    echo ""

    check_prerequisites

    cd "$PROJECT_DIR"

    case "$ACTION" in
        preview)
            start_preview
            ;;
        update)
            push_update "$4"
            ;;
        build)
            case "$PLATFORM" in
                android)
                    build_android
                    ;;
                ios)
                    build_ios
                    ;;
                all)
                    build_android
                    build_ios
                    ;;
                *)
                    log_error "Unknown platform: $PLATFORM"
                    exit 1
                    ;;
            esac
            ;;
        submit)
            case "$PLATFORM" in
                android)
                    submit_android
                    ;;
                ios)
                    submit_ios
                    ;;
                all)
                    submit_ios
                    submit_android
                    ;;
                *)
                    log_error "Unknown platform: $PLATFORM"
                    exit 1
                    ;;
            esac
            ;;
        both)
            case "$PLATFORM" in
                android)
                    build_android && submit_android
                    ;;
                ios)
                    build_ios && submit_ios
                    ;;
                all)
                    build_android
                    build_ios
                    submit_ios
                    submit_android
                    ;;
                *)
                    log_error "Unknown platform: $PLATFORM"
                    exit 1
                    ;;
            esac
            ;;
        *)
            log_error "Unknown action: $ACTION"
            echo "Usage: $0 [project_dir] [android|ios|all|preview] [build|submit|both|preview|update]"
            exit 1
            ;;
    esac

    log_success "Done!"
}

main "$@"
