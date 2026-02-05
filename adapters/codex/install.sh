#!/bin/bash
# Codora App Build - Codex CLI Adapter Installer
# https://github.com/Daniel4SE/codora-app-build

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  🚀 Codora App Build - Codex Adapter       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo ""

CODEX_SKILLS="$HOME/.agents/skills"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create directories
echo -e "${YELLOW}[1/3]${NC} Creating directories..."
mkdir -p "$CODEX_SKILLS/expo-build"

# Copy/download files
echo -e "${YELLOW}[2/3]${NC} Installing skill..."

if [ -f "$SCRIPT_DIR/SKILL.md" ]; then
    cp "$SCRIPT_DIR/SKILL.md" "$CODEX_SKILLS/expo-build/"
else
    REPO_URL="https://raw.githubusercontent.com/Daniel4SE/codora-app-build/main/adapters/codex"
    curl -fsSL "$REPO_URL/SKILL.md" -o "$CODEX_SKILLS/expo-build/SKILL.md"
fi

# Verify
echo -e "${YELLOW}[3/3]${NC} Verifying installation..."

if [ -f "$CODEX_SKILLS/expo-build/SKILL.md" ]; then
    echo ""
    echo -e "${GREEN}✅ Installation successful!${NC}"
    echo ""
    echo -e "${BLUE}Usage in Codex:${NC}"
    echo "  Type \$expo-build to invoke the skill"
    echo "  Or just ask: \"Build an APK for me\""
    echo ""
    echo -e "${BLUE}Installed to:${NC}"
    echo "  $CODEX_SKILLS/expo-build/SKILL.md"
    echo ""
else
    echo -e "${RED}❌ Installation failed!${NC}"
    exit 1
fi
