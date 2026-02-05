# 🚀 Codora CLI

Standalone CLI tool for building and deploying Expo/React Native apps.

## Installation

```bash
npm install -g codora
```

Or install from source:

```bash
git clone https://github.com/Daniel4SE/codora-app-build.git
cd codora-app-build/adapters/codora-cli
npm install -g .
```

## Usage

```bash
codora preview           # Start dev server
codora preview ios       # iOS simulator
codora preview android   # Android emulator
codora android           # Build APK
codora ios               # Build IPA
codora all               # Build all platforms
codora submit ios        # Submit to TestFlight
codora submit android    # Submit to Google Play
codora update "message"  # OTA hot update
codora status            # Check EAS status
```

## Prerequisites

1. **EAS CLI**: `npm install -g eas-cli`
2. **Expo Account**: `eas login`
3. **Project Config**: `eas build:configure` (in your project)

## Comparison

| Feature | Codora CLI | Claude Code Skill | OpenCode | Codex |
|---------|------------|-------------------|----------|-------|
| Standalone | ✅ | ❌ | ❌ | ❌ |
| AI-assisted | ❌ | ✅ | ✅ | ✅ |
| Natural language | ❌ | ✅ | ✅ | ✅ |
| Error handling | Basic | Smart | Smart | Smart |

## License

MIT
