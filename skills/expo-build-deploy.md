# Expo Build & Deploy Skill

## Description
自动化构建和部署 Expo/React Native 应用到 Android (APK) 和 iOS (TestFlight/App Store)。

## Trigger
当用户说以下内容时触发此 skill：
- "构建应用" / "build app"
- "部署应用" / "deploy app"
- "生成 APK" / "generate APK"
- "上传 TestFlight"
- "发布应用" / "publish app"
- "/build" / "/deploy"

## Prerequisites
- 项目必须是 Expo 项目（有 app.json 或 app.config.js）
- 需要 Expo 账户（免费）
- iOS App Store 发布需要 Apple Developer 账户（$99/年）

## Workflow

### Step 1: 检查环境
```bash
# 检查是否安装 EAS CLI
which eas || npm install -g eas-cli

# 检查登录状态
eas whoami
```

### Step 2: 配置 EAS（如果未配置）
```bash
# 初始化 EAS 配置
eas build:configure --platform all
```

确保 eas.json 包含以下配置：
```json
{
  "cli": {
    "version": ">= 5.0.0"
  },
  "build": {
    "development": {
      "developmentClient": true,
      "distribution": "internal",
      "ios": { "simulator": true }
    },
    "preview": {
      "distribution": "internal",
      "android": { "buildType": "apk" },
      "ios": { "simulator": false }
    },
    "production": {
      "android": { "buildType": "app-bundle" },
      "ios": { "distribution": "store" }
    }
  },
  "submit": {
    "production": {}
  }
}
```

### Step 3: 构建 Android APK
```bash
# 构建 APK（用于测试分发）
eas build --platform android --profile preview

# 或构建 AAB（用于 Google Play）
eas build --platform android --profile production
```

### Step 4: 构建 iOS
```bash
# 构建用于 App Store/TestFlight
eas build --platform ios --profile production
```

### Step 5: 获取构建产物
```bash
# 列出最近的构建
eas build:list --platform android --limit 1
eas build:list --platform ios --limit 1

# 查看构建详情（获取下载链接）
eas build:view <BUILD_ID>
```

### Step 6: 下载 APK/IPA 到本地
```bash
# 下载 Android APK
curl -L -o ~/Desktop/AppName.apk "<APK_URL>"

# 下载 iOS IPA
curl -L -o ~/Desktop/AppName.ipa "<IPA_URL>"
```

### Step 7: 上传 iOS 到 App Store Connect
```bash
# 方法 1: 使用 EAS Submit
eas submit --platform ios --url <IPA_URL>

# 方法 2: 使用 Transporter App
open -a Transporter ~/Desktop/AppName.ipa
```

### Step 8: 上传 Android 到 Google Play
```bash
# 需要先构建 AAB 格式
eas build --platform android --profile production

# 然后提交
eas submit --platform android
```

## 交互式命令（使用 expect）

### 登录 Expo
```bash
expect -c '
spawn eas login
expect "Email or username:"
send "YOUR_EMAIL\r"
expect "Password:"
send "YOUR_PASSWORD\r"
expect eof
'
```

### 构建 Android（自动确认）
```bash
expect -c '
set timeout 600
spawn eas build --platform android --profile preview
expect {
    "Generate a new Android Keystore" { send "y\r"; exp_continue }
    "Would you like" { send "y\r"; exp_continue }
    -re "https://expo.dev/accounts.*builds" { puts "Build started!" }
    eof
}
'
```

### 构建 iOS（自动确认）
```bash
expect -c '
set timeout 600
spawn eas build --platform ios --profile production
expect {
    "standard/exempt encryption" { send "y\r"; exp_continue }
    "log in to your Apple" { send "y\r"; exp_continue }
    "Generate a new" { send "y\r"; exp_continue }
    "Would you like" { send "y\r"; exp_continue }
    -re "https://expo.dev/accounts.*builds" { puts "Build started!" }
    eof
}
'
```

## 等待构建完成
```bash
BUILD_ID="<BUILD_ID>"
while true; do
    STATUS=$(eas build:view $BUILD_ID 2>&1 | grep "Status" | awk '{print $2}')
    echo "Status: $STATUS"
    if [ "$STATUS" = "finished" ]; then
        echo "Build completed!"
        eas build:view $BUILD_ID | grep "Application Archive URL"
        break
    elif [ "$STATUS" = "errored" ]; then
        echo "Build failed!"
        break
    fi
    sleep 30
done
```

## 完整自动化脚本示例

```bash
#!/bin/bash
# expo-build-deploy.sh

PROJECT_DIR="$1"
PLATFORM="$2"  # android, ios, or all

cd "$PROJECT_DIR" || exit 1

# 检查 EAS CLI
which eas || npm install -g eas-cli

# 检查登录
eas whoami || { echo "Please run: eas login"; exit 1; }

# 构建
if [ "$PLATFORM" = "android" ] || [ "$PLATFORM" = "all" ]; then
    echo "Building Android APK..."
    eas build --platform android --profile preview --non-interactive
fi

if [ "$PLATFORM" = "ios" ] || [ "$PLATFORM" = "all" ]; then
    echo "Building iOS..."
    eas build --platform ios --profile production
fi

# 获取最新构建
echo "Latest builds:"
eas build:list --limit 2
```

## 测试方法

### Android APK 测试
1. **直接安装**: 将 APK 传到手机，打开安装
2. **ADB 安装**: `adb install app.apk`
3. **扫码下载**: 生成 APK URL 的二维码

### iOS TestFlight 测试
1. 上传 IPA 到 App Store Connect
2. 等待 5-15 分钟处理
3. 在 TestFlight 添加测试员
4. 测试员用 TestFlight App 安装

## 常见问题

### Q: 构建失败怎么办？
A: 查看构建日志：`eas build:view <BUILD_ID>` 或访问 Expo 网站查看详细日志

### Q: iOS 构建需要什么？
A: 需要 Apple Developer 账户（$99/年），EAS 会自动管理证书和配置文件

### Q: 如何更新已发布的应用？
A: 增加 app.json 中的版本号，然后重新构建和提交

### Q: 如何使用 OTA 更新？
A: 使用 `eas update` 进行代码热更新（不需要重新提交商店）

## 输出

执行此 skill 后，应提供：
1. Android APK 下载链接和本地文件路径
2. iOS IPA 下载链接和本地文件路径
3. TestFlight 状态（如已上传）
4. 下一步操作指引
