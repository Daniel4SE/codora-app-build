# 🚀 Codora App Build

Claude Code で Expo/React Native アプリをワンクリックでビルド＆デプロイ。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**🌍 言語**: [English](../README.md) | [简体中文](./README_CN.md) | 日本語 | [한국어](./README_KR.md) | [Español](./README_ES.md) | [Français](./README_FR.md) | [Deutsch](./README_DE.md)

---

## ✨ 機能

- 🔥 **ローカルプレビュー** - 数秒で開発サーバー起動
- 📱 **APK ビルド** - Android パッケージを自動ビルド
- 🍎 **IPA ビルド** - iOS パッケージを自動ビルド
- 🚀 **ストア提出** - App Store / Google Play へワンクリック提出
- ⚡ **OTA アップデート** - ストア再申請なしでホットアップデート

## 📦 インストール

### 方法 1: ワンライナーインストール

```bash
curl -fsSL https://raw.githubusercontent.com/Daniel4SE/codora-app-build/main/install.sh | bash
```

### 方法 2: クローン＆インストール

```bash
git clone https://github.com/Daniel4SE/codora-app-build.git
cd codora-app-build
./install.sh
```

## 🎯 使い方

Claude Code で入力：

```
/build preview          # 🚀 ローカルプレビュー（最速）
/build android          # 📱 Android APK ビルド
/build ios              # 🍎 iOS IPA ビルド
/build all              # 📱🍎 全プラットフォームビルド
/build submit ios       # TestFlight に提出
/build update           # OTA ホットアップデート
```

または自然言語で：
- 「APK をビルドして」
- 「TestFlight にデプロイ」
- 「アプリをプレビュー」

## 📋 コマンドリファレンス

| コマンド | 説明 | 所要時間 |
|---------|------|---------|
| `/build preview` | ローカル開発プレビュー | 数秒 |
| `/build android` | Android APK ビルド | 10-15分 |
| `/build ios` | iOS IPA ビルド | 10-15分 |
| `/build all` | 全プラットフォームビルド | 15-20分 |
| `/build submit ios` | TestFlight に提出 | 1-5分 |
| `/build update` | OTA ホットアップデート | 1-2分 |

## 🔧 前提条件

| 要件 | 用途 | 費用 |
|-----|------|-----|
| [Node.js](https://nodejs.org/) | ランタイム | 無料 |
| [Expo アカウント](https://expo.dev/) | クラウドビルド | 無料 |
| [Apple Developer](https://developer.apple.com/) | iOS 公開 | $99/年 |
| [Google Play Console](https://play.google.com/console/) | Android 公開 | $25 一回 |

## 🚀 クイックスタート

```bash
# 1. EAS CLI をインストール
npm install -g eas-cli

# 2. Expo にログイン
eas login

# 3. プロジェクトで初期化
cd your-expo-project
eas build:configure

# 4. Claude Code で /build コマンドを使用
```

## ❓ よくある質問

**ビルドが遅い？** 日常開発には `/build preview`、配布時のみクラウドビルドを使用。

**アプリの更新方法？** 小さな更新は `/build update`、大きな更新はバージョン変更後に再ビルド＆提出。

**iOS ビルドに Mac が必要？** 不要！EAS クラウドビルドはサーバー上で実行されます。

---

⭐ 役に立ったらスターをお願いします！
