#!/bin/bash
# Claude Expo Build Skill Installer
# https://github.com/realdanieltang/claude-expo-build-skill

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  🚀 Claude Expo Build Skill Installer      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo ""

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

# Create directories
echo -e "${YELLOW}[1/4]${NC} Creating directories..."
mkdir -p "$CLAUDE_DIR/commands"
mkdir -p "$CLAUDE_DIR/scripts"
mkdir -p "$CLAUDE_DIR/skills"

# Copy files
echo -e "${YELLOW}[2/4]${NC} Copying skill files..."

# Check if running from git clone or curl
if [ -f "$SCRIPT_DIR/commands/build.md" ]; then
    # Running from local directory
    cp "$SCRIPT_DIR/commands/build.md" "$CLAUDE_DIR/commands/"
    cp "$SCRIPT_DIR/scripts/expo-build.sh" "$CLAUDE_DIR/scripts/"
    cp "$SCRIPT_DIR/skills/expo-build-deploy.md" "$CLAUDE_DIR/skills/"
else
    # Download from GitHub
    echo -e "${YELLOW}    Downloading from GitHub...${NC}"
    REPO_URL="https://raw.githubusercontent.com/Daniel4SE/claude-expo-build-skill/main"
    curl -fsSL "$REPO_URL/commands/build.md" -o "$CLAUDE_DIR/commands/build.md"
    curl -fsSL "$REPO_URL/scripts/expo-build.sh" -o "$CLAUDE_DIR/scripts/expo-build.sh"
    curl -fsSL "$REPO_URL/skills/expo-build-deploy.md" -o "$CLAUDE_DIR/skills/expo-build-deploy.md"
fi

# Set permissions
echo -e "${YELLOW}[3/4]${NC} Setting permissions..."
chmod +x "$CLAUDE_DIR/scripts/expo-build.sh"

# Verify installation
echo -e "${YELLOW}[4/4]${NC} Verifying installation..."

if [ -f "$CLAUDE_DIR/commands/build.md" ] && \
   [ -f "$CLAUDE_DIR/scripts/expo-build.sh" ] && \
   [ -f "$CLAUDE_DIR/skills/expo-build-deploy.md" ]; then
    echo ""
    echo -e "${GREEN}✅ Installation successful!${NC}"
    echo ""
    echo -e "${BLUE}Installed files:${NC}"
    echo "  • $CLAUDE_DIR/commands/build.md"
    echo "  • $CLAUDE_DIR/scripts/expo-build.sh"
    echo "  • $CLAUDE_DIR/skills/expo-build-deploy.md"
    echo ""
    echo -e "${BLUE}Usage:${NC}"
    echo "  In Claude Code, type:"
    echo ""
    echo "    /build preview     - Local preview (fastest)"
    echo "    /build android     - Build Android APK"
    echo "    /build ios         - Build iOS IPA"
    echo "    /build all         - Build all platforms"
    echo "    /build submit ios  - Submit to TestFlight"
    echo ""
    echo -e "${YELLOW}Prerequisites:${NC}"
    echo "  1. Install EAS CLI:  npm install -g eas-cli"
    echo "  2. Login to Expo:    eas login"
    echo "  3. Configure project: eas build:configure"
    echo ""
else
    echo -e "${RED}❌ Installation failed!${NC}"
    echo "Please try manual installation."
    exit 1
fi
