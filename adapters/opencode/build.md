---
description: Build and deploy Expo/React Native apps
agent: default
---

# /build - Expo App Build & Deploy

Build and deploy the current Expo/React Native project.

## Usage

```
/build $ARGUMENTS
```

**Arguments:**
- `preview` - Local dev preview (fastest)
- `preview ios` - iOS simulator preview
- `preview android` - Android emulator preview
- `android` - Build Android APK
- `ios` - Build iOS IPA
- `all` - Build all platforms
- `submit ios` - Submit to TestFlight
- `submit android` - Submit to Google Play
- `update` - OTA hot update

## Workflow

Based on the argument "$ARGUMENTS", execute the appropriate action:

### preview (or preview ios/android)
```bash
npx expo start
```
Or for specific platform: `npx expo start --ios` / `npx expo start --android`

### android
```bash
eas build --platform android --profile production --non-interactive
```
After build completes, download the APK to ~/Desktop/

### ios
```bash
eas build --platform ios --profile production --non-interactive
```
After build completes, download the IPA to ~/Desktop/

### all
Run both android and ios builds sequentially.

### submit ios
```bash
eas submit --platform ios --latest --non-interactive
```

### submit android
```bash
eas submit --platform android --latest --non-interactive
```

### update
```bash
eas update --branch production --message "OTA update"
```

## Prerequisites Check

Before building, verify:
1. EAS CLI is installed: `which eas`
2. User is logged in: `eas whoami`
3. Project has eas.json configuration
4. Project has valid app.json/app.config.js

## Output

- APK saved to: `~/Desktop/{project-name}.apk`
- IPA saved to: `~/Desktop/{project-name}.ipa`
