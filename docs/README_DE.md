# 🚀 Codora App Build

Ein-Klick-Build und Deployment für Expo/React Native Apps mit Claude Code.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**🌍 Sprache**: [English](../README.md) | [简体中文](./README_CN.md) | [日本語](./README_JP.md) | [한국어](./README_KR.md) | [Español](./README_ES.md) | [Français](./README_FR.md) | Deutsch

---

## ✨ Funktionen

- 🔥 **Lokale Vorschau** - Entwicklungsserver in Sekunden starten
- 📱 **APK erstellen** - Automatischer Build von Android-Paketen
- 🍎 **IPA erstellen** - Automatischer Build von iOS-Paketen
- 🚀 **Store-Einreichung** - Ein-Klick-Einreichung zu App Store / Google Play
- ⚡ **OTA-Updates** - Hot-Updates ohne Store-Neueinreichung

## 📦 Installation

### Option 1: Ein-Zeilen-Installation

```bash
curl -fsSL https://raw.githubusercontent.com/Daniel4SE/codora-app-build/main/install.sh | bash
```

### Option 2: Klonen & Installieren

```bash
git clone https://github.com/Daniel4SE/codora-app-build.git
cd codora-app-build
./install.sh
```

## 🎯 Verwendung

In Claude Code eingeben:

```
/build preview          # 🚀 Lokale Vorschau (am schnellsten)
/build android          # 📱 Android APK erstellen
/build ios              # 🍎 iOS IPA erstellen
/build all              # 📱🍎 Alle Plattformen erstellen
/build submit ios       # An TestFlight einreichen
/build update           # OTA Hot-Update
```

Oder in natürlicher Sprache:
- "Erstelle die APK"
- "Deploye zu TestFlight"
- "App-Vorschau"

## 📋 Befehlsreferenz

| Befehl | Beschreibung | Zeit |
|--------|--------------|------|
| `/build preview` | Lokale Entwicklungsvorschau | Sekunden |
| `/build android` | Android APK erstellen | 10-15 Min |
| `/build ios` | iOS IPA erstellen | 10-15 Min |
| `/build all` | Alle Plattformen erstellen | 15-20 Min |
| `/build submit ios` | An TestFlight einreichen | 1-5 Min |
| `/build update` | OTA Hot-Update | 1-2 Min |

## 🔧 Voraussetzungen

| Anforderung | Zweck | Kosten |
|-------------|-------|--------|
| [Node.js](https://nodejs.org/) | Laufzeitumgebung | Kostenlos |
| [Expo-Konto](https://expo.dev/) | Cloud-Builds | Kostenlos |
| [Apple Developer](https://developer.apple.com/) | iOS-Veröffentlichung | 99$/Jahr |
| [Google Play Console](https://play.google.com/console/) | Android-Veröffentlichung | 25$ einmalig |

## 🚀 Schnellstart

```bash
# 1. EAS CLI installieren
npm install -g eas-cli

# 2. Bei Expo anmelden
eas login

# 3. In Ihrem Projekt initialisieren
cd your-expo-project
eas build:configure

# 4. /build-Befehl in Claude Code verwenden
```

## ❓ Häufige Fragen

**Build zu langsam?** Verwenden Sie `/build preview` für die tägliche Entwicklung, Cloud-Builds nur bei der Distribution.

**Wie aktualisiert man eine veröffentlichte App?** Kleine Updates: `/build update`. Große Updates: Version ändern, neu bauen und einreichen.

**Brauche ich einen Mac für iOS-Builds?** Nein! EAS Cloud-Builds laufen auf Servern.

---

⭐ Gib einen Stern, wenn du es nützlich findest!
