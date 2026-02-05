# 🚀 Claude Expo Build Skill

一键构建、预览、部署 Expo/React Native 应用的 Claude Code Skill。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ 功能

- 🔥 **本地预览** - 秒级启动开发服务器
- 📱 **构建 APK** - 自动构建 Android 安装包
- 🍎 **构建 IPA** - 自动构建 iOS 安装包
- 🚀 **提交商店** - 一键提交到 App Store / Google Play
- ⚡ **OTA 更新** - 热更新无需重新提交审核

## 📦 安装

### 方法 1: 一键安装

```bash
curl -fsSL https://raw.githubusercontent.com/realdanieltang/claude-expo-build-skill/main/install.sh | bash
```

### 方法 2: 手动安装

```bash
# 克隆仓库
git clone https://github.com/realdanieltang/claude-expo-build-skill.git
cd claude-expo-build-skill

# 运行安装脚本
./install.sh
```

### 方法 3: 复制文件

```bash
# 创建目录
mkdir -p ~/.claude/{commands,scripts,skills}

# 复制文件
cp commands/build.md ~/.claude/commands/
cp scripts/expo-build.sh ~/.claude/scripts/
cp skills/expo-build-deploy.md ~/.claude/skills/

# 添加执行权限
chmod +x ~/.claude/scripts/expo-build.sh
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
| `/build preview ios` | iOS 模拟器预览 | 几秒 |
| `/build preview android` | Android 模拟器预览 | 几秒 |
| `/build android` | 构建 Android APK | 10-15分钟 |
| `/build ios` | 构建 iOS IPA | 10-15分钟 |
| `/build all` | 构建全部平台 | 15-20分钟 |
| `/build submit ios` | 提交到 TestFlight | 1-5分钟 |
| `/build submit android` | 提交到 Google Play | 1-5分钟 |
| `/build update` | OTA 热更新 | 1-2分钟 |

## 🔧 前置要求

| 要求 | 用途 | 费用 |
|------|------|------|
| [Node.js](https://nodejs.org/) | 运行环境 | 免费 |
| [Expo 账户](https://expo.dev/) | 云构建 | 免费 |
| [EAS CLI](https://docs.expo.dev/eas/) | 构建工具 | 免费 |
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

# 4. 使用 /build 命令
# 在 Claude Code 中输入 /build preview
```

## 📁 文件结构

```
~/.claude/
├── commands/
│   └── build.md          # Skill 命令定义
├── scripts/
│   └── expo-build.sh     # 构建脚本
└── skills/
    └── expo-build-deploy.md  # 详细文档
```

## 📤 输出文件

构建完成后，文件保存在：

```
~/Desktop/
├── {项目名}.apk    # Android 安装包
└── {项目名}.ipa    # iOS 安装包
```

## ❓ 常见问题

<details>
<summary><b>构建太慢怎么办？</b></summary>

- 日常开发用 `/build preview`，秒开
- 只在需要分发时用 `/build android/ios`
</details>

<details>
<summary><b>如何更新已发布的 App？</b></summary>

- 小更新：`/build update`（OTA，即时生效）
- 大更新：修改版本号 → `/build all` → `/build submit`
</details>

<details>
<summary><b>iOS 构建需要 Mac 吗？</b></summary>

不需要！EAS 云构建在服务器上完成，任何系统都可以。
</details>

<details>
<summary><b>如何添加测试员？</b></summary>

- **iOS**: App Store Connect → TestFlight → 添加测试员
- **Android**: Google Play Console → 内部测试 → 添加邮箱
</details>

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE)

## 👤 作者

**Daniel Tang**
- GitHub: [@realdanieltang](https://github.com/realdanieltang)
- Email: realdanieltang@gmail.com

---

⭐ 如果这个 Skill 对你有帮助，请给个 Star！
