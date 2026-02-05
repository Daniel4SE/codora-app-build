---
name: expo-build
description: Build and deploy Expo/React Native applications with EAS. Use this skill when the user wants to build APK, IPA, preview apps, submit to app stores, or perform OTA updates.
---

# Expo Build & Deploy Skill

You are an expert at building and deploying Expo/React Native applications using EAS (Expo Application Services).

## Capabilities

- **Local Preview**: Start development server with `npx expo start`
- **Build APK**: Create Android packages with `eas build --platform android`
- **Build IPA**: Create iOS packages with `eas build --platform ios`
- **Store Submit**: Submit to TestFlight/Google Play with `eas submit`
- **OTA Updates**: Push hot updates with `eas update`

## Workflow

### 1. Environment Check
Before any build operation, verify:
```bash
# Check EAS CLI
which eas || echo "EAS CLI not installed. Run: npm install -g eas-cli"

# Check login status
eas whoami || echo "Not logged in. Run: eas login"

# Check project configuration
[ -f "eas.json" ] || echo "No eas.json found. Run: eas build:configure"
```

### 2. Build Commands

**Preview (Development)**
```bash
npx expo start                    # Universal
npx expo start --ios              # iOS simulator
npx expo start --android          # Android emulator
```

**Production Builds**
```bash
eas build --platform android --profile production --non-interactive
eas build --platform ios --profile production --non-interactive
```

**Download Artifacts**
After build completes, download to desktop:
```bash
# Get build URL from eas build output, then:
curl -L "<build-url>" -o ~/Desktop/app.apk
curl -L "<build-url>" -o ~/Desktop/app.ipa
```

### 3. Store Submission
```bash
eas submit --platform ios --latest --non-interactive
eas submit --platform android --latest --non-interactive
```

### 4. OTA Updates
```bash
eas update --branch production --message "Update description"
```

## Best Practices

1. Use `preview` for daily development (instant)
2. Only use cloud builds when distributing
3. Small updates → OTA (`eas update`)
4. Major updates → New build + submit

## Prerequisites

| Requirement | Command |
|-------------|---------|
| Node.js | Required |
| EAS CLI | `npm install -g eas-cli` |
| Expo Account | `eas login` |
| Apple Developer | For iOS builds ($99/year) |
| Google Play Console | For Android publish ($25 one-time) |
