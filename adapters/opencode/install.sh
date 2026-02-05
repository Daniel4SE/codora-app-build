#!/bin/bash
# Codora App Build - OpenCode Adapter Installer
# https://github.com/Daniel4SE/codora-app-build

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  🚀 Codora App Build - OpenCode Adapter    ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo ""

OPENCODE_DIR="$HOME/.config/opencode"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create directories
echo -e "${YELLOW}[1/3]${NC} Creating directories..."
mkdir -p "$OPENCODE_DIR/commands"
mkdir -p "$OPENCODE_DIR/skills/expo-build"

# Copy/download files
echo -e "${YELLOW}[2/3]${NC} Installing skill files..."

if [ -f "$SCRIPT_DIR/build.md" ]; then
    cp "$SCRIPT_DIR/build.md" "$OPENCODE_DIR/commands/"
    cp "$SCRIPT_DIR/SKILL.md" "$OPENCODE_DIR/skills/expo-build/"
else
    REPO_URL="https://raw.githubusercontent.com/Daniel4SE/codora-app-build/main/adapters/opencode"
    curl -fsSL "$REPO_URL/build.md" -o "$OPENCODE_DIR/commands/build.md"
    curl -fsSL "$REPO_URL/SKILL.md" -o "$OPENCODE_DIR/skills/expo-build/SKILL.md"
fi

# Verify
echo -e "${YELLOW}[3/3]${NC} Verifying installation..."

if [ -f "$OPENCODE_DIR/commands/build.md" ]; then
    echo ""
    echo -e "${GREEN}✅ Installation successful!${NC}"
    echo ""
    echo -e "${BLUE}Usage in OpenCode:${NC}"
    echo "  /build preview     - Local preview"
    echo "  /build android     - Build APK"
    echo "  /build ios         - Build IPA"
    echo ""
else
    echo -e "${RED}❌ Installation failed!${NC}"
    exit 1
fi
