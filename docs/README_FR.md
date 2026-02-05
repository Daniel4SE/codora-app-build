# 🚀 Codora App Build

Construction et déploiement en un clic pour les applications Expo/React Native avec Claude Code.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**🌍 Langue**: [English](../README.md) | [简体中文](./README_CN.md) | [日本語](./README_JP.md) | [한국어](./README_KR.md) | [Español](./README_ES.md) | Français | [Deutsch](./README_DE.md)

---

## ✨ Fonctionnalités

- 🔥 **Aperçu local** - Démarrez le serveur de développement en quelques secondes
- 📱 **Construire APK** - Construction automatique des packages Android
- 🍎 **Construire IPA** - Construction automatique des packages iOS
- 🚀 **Soumission aux stores** - Soumission en un clic vers App Store / Google Play
- ⚡ **Mises à jour OTA** - Mises à jour à chaud sans re-soumission aux stores

## 📦 Installation

### Option 1: Installation en une ligne

```bash
curl -fsSL https://raw.githubusercontent.com/Daniel4SE/codora-app-build/main/install.sh | bash
```

### Option 2: Cloner et installer

```bash
git clone https://github.com/Daniel4SE/codora-app-build.git
cd codora-app-build
./install.sh
```

## 🎯 Utilisation

Dans Claude Code, tapez:

```
/build preview          # 🚀 Aperçu local (le plus rapide)
/build android          # 📱 Construire APK Android
/build ios              # 🍎 Construire IPA iOS
/build all              # 📱🍎 Construire toutes les plateformes
/build submit ios       # Soumettre à TestFlight
/build update           # Mise à jour OTA à chaud
```

Ou utilisez le langage naturel:
- "Construis l'APK"
- "Déploie sur TestFlight"
- "Aperçu de l'application"

## 📋 Référence des commandes

| Commande | Description | Durée |
|----------|-------------|-------|
| `/build preview` | Aperçu de développement local | Secondes |
| `/build android` | Construire APK Android | 10-15 min |
| `/build ios` | Construire IPA iOS | 10-15 min |
| `/build all` | Construire toutes les plateformes | 15-20 min |
| `/build submit ios` | Soumettre à TestFlight | 1-5 min |
| `/build update` | Mise à jour OTA à chaud | 1-2 min |

## 🔧 Prérequis

| Exigence | But | Coût |
|----------|-----|------|
| [Node.js](https://nodejs.org/) | Environnement d'exécution | Gratuit |
| [Compte Expo](https://expo.dev/) | Builds cloud | Gratuit |
| [Apple Developer](https://developer.apple.com/) | Publication iOS | 99$/an |
| [Google Play Console](https://play.google.com/console/) | Publication Android | 25$ unique |

## 🚀 Démarrage rapide

```bash
# 1. Installer EAS CLI
npm install -g eas-cli

# 2. Se connecter à Expo
eas login

# 3. Initialiser dans votre projet
cd your-expo-project
eas build:configure

# 4. Utilisez la commande /build dans Claude Code
```

## ❓ Questions fréquentes

**Construction trop lente?** Utilisez `/build preview` pour le développement quotidien, utilisez les builds cloud uniquement lors de la distribution.

**Comment mettre à jour une app publiée?** Petites mises à jour: `/build update`. Mises à jour majeures: changez la version, reconstruisez et soumettez.

**Ai-je besoin d'un Mac pour construire iOS?** Non! Les builds cloud EAS s'exécutent sur des serveurs.

---

⭐ Mettez une étoile si vous trouvez cela utile!
