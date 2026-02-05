---
name: expo-build
description: Build and deploy Expo/React Native apps. Use when user wants to build APK/IPA, preview apps, submit to app stores, or perform OTA updates. Invoke with $expo-build.
---

# Expo Build & Deploy Skill

Expert at building and deploying Expo/React Native applications using EAS (Expo Application Services).

## Quick Commands

| Task | Command |
|------|---------|
| Preview | `npx expo start` |
| Build Android | `eas build --platform android --profile production` |
| Build iOS | `eas build --platform ios --profile production` |
| Submit iOS | `eas submit --platform ios --latest` |
| Submit Android | `eas submit --platform android --latest` |
| OTA Update | `eas update --branch production` |

## Detailed Workflow

### 1. Prerequisites Check

Always verify environment first:

```bash
# Check EAS CLI installed
which eas || npm install -g eas-cli

# Check logged in
eas whoami || eas login

# Check project configured
[ -f "eas.json" ] || eas build:configure
```

### 2. Local Preview (Fastest - Use for Development)

```bash
# Start dev server
npx expo start

# Platform specific
npx expo start --ios        # iOS simulator
npx expo start --android    # Android emulator
```

### 3. Production Builds (Cloud)

**Android APK:**
```bash
eas build --platform android --profile production --non-interactive
```

**iOS IPA:**
```bash
eas build --platform ios --profile production --non-interactive
```

**Both Platforms:**
```bash
eas build --platform all --profile production --non-interactive
```

### 4. Download Build Artifacts

After build completes, get the download URL from build output:

```bash
# Download APK
curl -L "https://expo.dev/artifacts/eas/BUILD_ID.apk" -o ~/Desktop/app.apk

# Download IPA
curl -L "https://expo.dev/artifacts/eas/BUILD_ID.ipa" -o ~/Desktop/app.ipa
```

### 5. Store Submission

**TestFlight (iOS):**
```bash
eas submit --platform ios --latest --non-interactive
```

**Google Play:**
```bash
eas submit --platform android --latest --non-interactive
```

### 6. OTA Hot Updates

For small changes without store re-submission:

```bash
eas update --branch production --message "Bug fixes and improvements"
```

## Decision Guide

| Scenario | Action |
|----------|--------|
| Daily development | `npx expo start` |
| Give APK to testers | `eas build --platform android` |
| Submit to App Store | `eas build --platform ios` then `eas submit` |
| Quick bug fix in production | `eas update` (OTA) |
| Major version release | Build + Submit + Update version in app.json |

## Requirements

- **Node.js**: Runtime environment
- **EAS CLI**: `npm install -g eas-cli`
- **Expo Account**: Free at https://expo.dev
- **Apple Developer**: $99/year (iOS only)
- **Google Play Console**: $25 one-time (Android only)
