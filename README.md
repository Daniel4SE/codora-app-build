# 🚀 Codora App Build

One-click build and deploy for Expo/React Native apps.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/Daniel4SE/codora-app-build)](https://github.com/Daniel4SE/codora-app-build/stargazers)

**🌍 Language**: English | [简体中文](./docs/README_CN.md) | [日本語](./docs/README_JP.md) | [한국어](./docs/README_KR.md) | [Español](./docs/README_ES.md) | [Français](./docs/README_FR.md) | [Deutsch](./docs/README_DE.md)

---

## 🔌 Supported Platforms

| Platform | Status | Install Command |
|----------|--------|-----------------|
| **Claude Code** | ✅ Full Support | `curl -fsSL .../install.sh \| bash` |
| **OpenCode** | ✅ Full Support | `curl -fsSL .../adapters/opencode/install.sh \| bash` |
| **Codex CLI** | ✅ Full Support | `curl -fsSL .../adapters/codex/install.sh \| bash` |
| **Codora CLI** | ✅ Standalone | `npm install -g codora` |

## ✨ Features

- 🔥 **Local Preview** - Start dev server in seconds
- 📱 **Build APK** - Auto-build Android packages
- 🍎 **Build IPA** - Auto-build iOS packages
- 🚀 **Store Submit** - One-click submit to App Store / Google Play
- ⚡ **OTA Updates** - Hot updates without store re-submission

## 📦 Installation

### Option 1: One-line Install

```bash
curl -fsSL https://raw.githubusercontent.com/Daniel4SE/codora-app-build/main/install.sh | bash
```

### Option 2: Clone & Install

```bash
git clone https://github.com/Daniel4SE/codora-app-build.git
cd codora-app-build
./install.sh
```

### Option 3: Manual Install

```bash
# Create directories
mkdir -p ~/.claude/{commands,scripts,skills}

# Download files
curl -fsSL https://raw.githubusercontent.com/Daniel4SE/codora-app-build/main/commands/build.md -o ~/.claude/commands/build.md
curl -fsSL https://raw.githubusercontent.com/Daniel4SE/codora-app-build/main/scripts/expo-build.sh -o ~/.claude/scripts/expo-build.sh
curl -fsSL https://raw.githubusercontent.com/Daniel4SE/codora-app-build/main/skills/expo-build-deploy.md -o ~/.claude/skills/expo-build-deploy.md

# Set permissions
chmod +x ~/.claude/scripts/expo-build.sh
```

## 🎯 Usage

In Claude Code, type:

```
/build preview          # 🚀 Local preview (fastest)
/build android          # 📱 Build Android APK
/build ios              # 🍎 Build iOS IPA
/build all              # 📱🍎 Build all platforms
/build submit ios       # Submit to TestFlight
/build update           # OTA hot update
```

Or use natural language:
- "Build APK for me"
- "Deploy to TestFlight"
- "Preview the app"

## 📋 Command Reference

| Command | Description | Time |
|---------|-------------|------|
| `/build preview` | Local dev preview | Seconds |
| `/build preview ios` | iOS simulator preview | Seconds |
| `/build preview android` | Android emulator preview | Seconds |
| `/build android` | Build Android APK | 10-15 min |
| `/build ios` | Build iOS IPA | 10-15 min |
| `/build all` | Build all platforms | 15-20 min |
| `/build submit ios` | Submit to TestFlight | 1-5 min |
| `/build submit android` | Submit to Google Play | 1-5 min |
| `/build update` | OTA hot update | 1-2 min |

## 🔧 Prerequisites

| Requirement | Purpose | Cost |
|-------------|---------|------|
| [Node.js](https://nodejs.org/) | Runtime | Free |
| [Expo Account](https://expo.dev/) | Cloud builds | Free |
| [EAS CLI](https://docs.expo.dev/eas/) | Build tool | Free |
| [Apple Developer](https://developer.apple.com/) | iOS publishing | $99/year |
| [Google Play Console](https://play.google.com/console/) | Android publishing | $25 one-time |

## 🚀 Quick Start

```bash
# 1. Install EAS CLI
npm install -g eas-cli

# 2. Login to Expo
eas login

# 3. Initialize in your project
cd your-expo-project
eas build:configure

# 4. Use /build command in Claude Code
```

## 📁 File Structure

```
~/.claude/
├── commands/
│   └── build.md          # Skill command definition
├── scripts/
│   └── expo-build.sh     # Build script
└── skills/
    └── expo-build-deploy.md  # Detailed documentation
```

## 📤 Output Files

After build completion, files are saved to:

```
~/Desktop/
├── {project-name}.apk    # Android package
└── {project-name}.ipa    # iOS package
```

## ❓ FAQ

<details>
<summary><b>Build too slow?</b></summary>

- Use `/build preview` for daily development (instant)
- Only use `/build android/ios` when distributing
</details>

<details>
<summary><b>How to update a published app?</b></summary>

- Small updates: `/build update` (OTA, instant)
- Major updates: Change version → `/build all` → `/build submit`
</details>

<details>
<summary><b>Do I need a Mac for iOS builds?</b></summary>

No! EAS cloud builds run on servers, works from any OS.
</details>

<details>
<summary><b>How to add testers?</b></summary>

- **iOS**: App Store Connect → TestFlight → Add testers
- **Android**: Google Play Console → Internal testing → Add emails
</details>

## 🔧 Platform-Specific Installation

### Claude Code (Default)

```bash
curl -fsSL https://raw.githubusercontent.com/Daniel4SE/codora-app-build/main/install.sh | bash
```

Then use `/build` command in Claude Code.

### OpenCode

```bash
curl -fsSL https://raw.githubusercontent.com/Daniel4SE/codora-app-build/main/adapters/opencode/install.sh | bash
```

Then use `/build` command in OpenCode.

### Codex CLI

```bash
curl -fsSL https://raw.githubusercontent.com/Daniel4SE/codora-app-build/main/adapters/codex/install.sh | bash
```

Then use `$expo-build` skill in Codex, or just ask "Build an APK for me".

### Codora CLI (Standalone)

```bash
# Install globally
npm install -g codora

# Or from source
git clone https://github.com/Daniel4SE/codora-app-build.git
cd codora-app-build/adapters/codora-cli
npm install -g .
```

Usage:
```bash
codora preview        # Local dev server
codora android        # Build APK
codora ios            # Build IPA
codora submit ios     # Submit to TestFlight
codora update         # OTA update
```

## 🤝 Contributing

Contributions are welcome! Feel free to submit Issues and Pull Requests.

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

## 👤 Author

**Daniel Tang** - [@Daniel4SE](https://github.com/Daniel4SE)

---

⭐ Star this repo if you find it helpful!
