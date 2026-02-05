#!/bin/bash
# Expo Build & Deploy Script
# Usage: expo-build.sh [project_dir] [platform] [action]
# Platform: android, ios, all
# Action: build, submit, both

set -e

PROJECT_DIR="${1:-.}"
PLATFORM="${2:-all}"
ACTION="${3:-build}"
OUTPUT_DIR="$HOME/Desktop"

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
            echo "Usage: $0 [project_dir] [android|ios|all] [build|submit|both]"
            exit 1
            ;;
    esac

    log_success "Done!"
}

main "$@"
