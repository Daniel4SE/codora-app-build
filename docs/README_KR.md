# 🚀 Codora App Build

Claude Code로 Expo/React Native 앱을 원클릭 빌드 및 배포.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**🌍 언어**: [English](../README.md) | [简体中文](./README_CN.md) | [日本語](./README_JP.md) | 한국어 | [Español](./README_ES.md) | [Français](./README_FR.md) | [Deutsch](./README_DE.md)

---

## ✨ 기능

- 🔥 **로컬 미리보기** - 몇 초 만에 개발 서버 시작
- 📱 **APK 빌드** - Android 패키지 자동 빌드
- 🍎 **IPA 빌드** - iOS 패키지 자동 빌드
- 🚀 **스토어 제출** - App Store / Google Play에 원클릭 제출
- ⚡ **OTA 업데이트** - 스토어 재심사 없이 핫 업데이트

## 📦 설치

### 방법 1: 원라인 설치

```bash
curl -fsSL https://raw.githubusercontent.com/Daniel4SE/codora-app-build/main/install.sh | bash
```

### 방법 2: 클론 & 설치

```bash
git clone https://github.com/Daniel4SE/codora-app-build.git
cd codora-app-build
./install.sh
```

## 🎯 사용법

Claude Code에서 입력:

```
/build preview          # 🚀 로컬 미리보기 (가장 빠름)
/build android          # 📱 Android APK 빌드
/build ios              # 🍎 iOS IPA 빌드
/build all              # 📱🍎 모든 플랫폼 빌드
/build submit ios       # TestFlight에 제출
/build update           # OTA 핫 업데이트
```

또는 자연어로:
- "APK 빌드해줘"
- "TestFlight에 배포"
- "앱 미리보기"

## 📋 명령어 참조

| 명령어 | 설명 | 소요 시간 |
|-------|------|----------|
| `/build preview` | 로컬 개발 미리보기 | 몇 초 |
| `/build android` | Android APK 빌드 | 10-15분 |
| `/build ios` | iOS IPA 빌드 | 10-15분 |
| `/build all` | 모든 플랫폼 빌드 | 15-20분 |
| `/build submit ios` | TestFlight에 제출 | 1-5분 |
| `/build update` | OTA 핫 업데이트 | 1-2분 |

## 🔧 사전 요구사항

| 요구사항 | 용도 | 비용 |
|---------|------|-----|
| [Node.js](https://nodejs.org/) | 런타임 | 무료 |
| [Expo 계정](https://expo.dev/) | 클라우드 빌드 | 무료 |
| [Apple Developer](https://developer.apple.com/) | iOS 배포 | $99/년 |
| [Google Play Console](https://play.google.com/console/) | Android 배포 | $25 일회성 |

## 🚀 빠른 시작

```bash
# 1. EAS CLI 설치
npm install -g eas-cli

# 2. Expo 로그인
eas login

# 3. 프로젝트에서 초기화
cd your-expo-project
eas build:configure

# 4. Claude Code에서 /build 명령어 사용
```

## ❓ 자주 묻는 질문

**빌드가 너무 느린가요?** 일상 개발에는 `/build preview`, 배포 시에만 클라우드 빌드 사용.

**앱 업데이트 방법?** 작은 업데이트는 `/build update`, 큰 업데이트는 버전 변경 후 재빌드 및 제출.

**iOS 빌드에 Mac이 필요한가요?** 아니요! EAS 클라우드 빌드는 서버에서 실행됩니다.

---

⭐ 유용하셨다면 스타를 눌러주세요!
