# 🚀 Codora App Build

一键构建、部署 Expo/React Native 应用的 Claude Code 技能。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**🌍 语言**: [English](../README.md) | 简体中文 | [日本語](./README_JP.md) | [한국어](./README_KR.md) | [Español](./README_ES.md) | [Français](./README_FR.md) | [Deutsch](./README_DE.md)

---

## ✨ 功能

- 🔥 **本地预览** - 秒级启动开发服务器
- 📱 **构建 APK** - 自动构建 Android 安装包
- 🍎 **构建 IPA** - 自动构建 iOS 安装包
- 🚀 **提交商店** - 一键提交到 App Store / Google Play
- ⚡ **OTA 更新** - 热更新无需重新提交审核

## 📦 安装

### 方法 1: 一键安装

```bash
curl -fsSL https://raw.githubusercontent.com/Daniel4SE/codora-app-build/main/install.sh | bash
```

### 方法 2: 克隆安装

```bash
git clone https://github.com/Daniel4SE/codora-app-build.git
cd codora-app-build
./install.sh
```

## 🎯 使用方法

在 Claude Code 中输入：

```
/build preview          # 🚀 本地预览（最快）
/build android          # 📱 构建 Android APK
/build ios              # 🍎 构建 iOS IPA
/build all              # 📱🍎 构建全部
/build submit ios       # 提交到 TestFlight
/build update           # OTA 热更新
```

或者用自然语言：
- "帮我构建 APK"
- "部署到 TestFlight"
- "预览应用"

## 📋 命令参考

| 命令 | 说明 | 耗时 |
|------|------|------|
| `/build preview` | 本地开发预览 | 几秒 |
| `/build android` | 构建 Android APK | 10-15分钟 |
| `/build ios` | 构建 iOS IPA | 10-15分钟 |
| `/build all` | 构建全部平台 | 15-20分钟 |
| `/build submit ios` | 提交到 TestFlight | 1-5分钟 |
| `/build update` | OTA 热更新 | 1-2分钟 |

## 🔧 前置要求

| 要求 | 用途 | 费用 |
|------|------|------|
| [Node.js](https://nodejs.org/) | 运行环境 | 免费 |
| [Expo 账户](https://expo.dev/) | 云构建 | 免费 |
| [Apple Developer](https://developer.apple.com/) | iOS 发布 | $99/年 |
| [Google Play Console](https://play.google.com/console/) | Android 发布 | $25 一次性 |

## 🚀 快速开始

```bash
# 1. 安装 EAS CLI
npm install -g eas-cli

# 2. 登录 Expo
eas login

# 3. 在项目目录初始化
cd your-expo-project
eas build:configure

# 4. 在 Claude Code 中使用 /build 命令
```

## ❓ 常见问题

**构建太慢？** 日常开发用 `/build preview`，只在分发时用云构建。

**如何更新 App？** 小更新用 `/build update`，大更新改版本号后重新构建提交。

**iOS 需要 Mac？** 不需要！EAS 云构建在服务器上完成。

---

⭐ 觉得有用请给个 Star！
