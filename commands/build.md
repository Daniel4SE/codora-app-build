# /build - Expo App Build & Deploy

One-click build, preview, and deploy for Expo/React Native apps.

## Quick Start

```
/build preview          # 🚀 Local preview (fastest)
/build android          # 📱 Build Android APK
/build ios              # 🍎 Build iOS IPA
/build all              # 📱🍎 Build all platforms
/build submit ios       # 🚀 Submit to App Store
/build update           # ⚡ OTA hot update
```

## Full Syntax

```
/build [action] [platform] [options]
```

### Actions
| Action | Description | Time |
|--------|-------------|------|
| `preview` | Local dev server | Seconds |
| `build` | Cloud build APK/IPA | 10-15 min |
| `submit` | Submit to App Store/Google Play | 1-5 min |
| `update` | OTA hot update | 1-2 min |

### Platforms
| Platform | Description |
|----------|-------------|
| `ios` | iOS simulator/device |
| `android` | Android emulator/device |
| `all` | All platforms |
| `web` | Web version |

## Examples

### Local Preview (Recommended for daily dev)
```
/build preview              # Start Expo, scan QR
/build preview ios          # iOS simulator
/build preview android      # Android emulator
```

### Build Packages
```
/build android              # Build Android APK
/build ios                  # Build iOS IPA
/build all                  # Build all
```

### Submit to Store
```
/build submit ios           # Submit to TestFlight/App Store
/build submit android       # Submit to Google Play
```

### OTA Update (No store re-submission)
```
/build update               # Push code update to installed apps
```

## Workflow

```
┌─────────────────────────────────────────────────────────┐
│                    /build Workflow                       │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  preview ──→ Start local dev server ──→ Simulator/QR   │
│                                                         │
│  build ──→ Upload to EAS ──→ Cloud build ──→ Download  │
│                                                         │
│  submit ──→ Get build ──→ Upload to store ──→ Review   │
│                                                         │
│  update ──→ Bundle JS ──→ Push OTA ──→ Instant effect  │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## Output Files

| Type | Path |
|------|------|
| Android APK | `~/Desktop/{project-name}.apk` |
| iOS IPA | `~/Desktop/{project-name}.ipa` |
| Build logs | `https://expo.dev/accounts/{user}/projects/{project}/builds` |

## Prerequisites

| Requirement | Purpose | Cost |
|-------------|---------|------|
| Node.js | Runtime | Free |
| Expo Account | Cloud builds | Free |
| Apple Developer | iOS publishing | $99/year |
| Google Play Console | Android publishing | $25 one-time |

## Quick Setup

Run before first use:
```bash
# Install EAS CLI
npm install -g eas-cli

# Login to Expo
eas login

# Initialize project (in project directory)
eas build:configure
```

## FAQ

**Q: Port already in use?**
- Auto-detects port conflicts, switches to available port (8082, 8083...)
- Can also kill existing process or connect to existing server

**Q: Build too slow?**
- Use `/build preview` for daily dev (instant)
- Only use `/build android/ios` when distributing

**Q: How to update published app?**
- Small updates: `/build update` (OTA, instant)
- Major updates: Change version → `/build all` → `/build submit`

**Q: Need Mac for iOS builds?**
- No! EAS cloud builds run on servers

**Q: How to add testers?**
- iOS: App Store Connect → TestFlight → Add testers
- Android: Google Play Console → Internal testing → Add emails

## Related Commands

```bash
eas build:list          # View build history
eas build:view ID       # View build details
eas update              # OTA update
eas submit              # Submit to store
eas credentials         # Manage certificates
```

---
**Author**: Daniel Tang
**Version**: 1.1.0
**Repository**: https://github.com/Daniel4SE/codora-app-build
