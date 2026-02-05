# 🚀 Codora App Build

Construcción y despliegue de aplicaciones Expo/React Native con un solo clic usando Claude Code.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**🌍 Idioma**: [English](../README.md) | [简体中文](./README_CN.md) | [日本語](./README_JP.md) | [한국어](./README_KR.md) | Español | [Français](./README_FR.md) | [Deutsch](./README_DE.md)

---

## ✨ Características

- 🔥 **Vista previa local** - Inicia el servidor de desarrollo en segundos
- 📱 **Construir APK** - Construcción automática de paquetes Android
- 🍎 **Construir IPA** - Construcción automática de paquetes iOS
- 🚀 **Envío a tiendas** - Envío con un clic a App Store / Google Play
- ⚡ **Actualizaciones OTA** - Actualizaciones en caliente sin re-envío a tiendas

## 📦 Instalación

### Opción 1: Instalación de una línea

```bash
curl -fsSL https://raw.githubusercontent.com/Daniel4SE/codora-app-build/main/install.sh | bash
```

### Opción 2: Clonar e instalar

```bash
git clone https://github.com/Daniel4SE/codora-app-build.git
cd codora-app-build
./install.sh
```

## 🎯 Uso

En Claude Code, escribe:

```
/build preview          # 🚀 Vista previa local (más rápido)
/build android          # 📱 Construir APK Android
/build ios              # 🍎 Construir IPA iOS
/build all              # 📱🍎 Construir todas las plataformas
/build submit ios       # Enviar a TestFlight
/build update           # Actualización OTA en caliente
```

O usa lenguaje natural:
- "Construye el APK"
- "Despliega a TestFlight"
- "Vista previa de la app"

## 📋 Referencia de comandos

| Comando | Descripción | Tiempo |
|---------|-------------|--------|
| `/build preview` | Vista previa de desarrollo local | Segundos |
| `/build android` | Construir APK Android | 10-15 min |
| `/build ios` | Construir IPA iOS | 10-15 min |
| `/build all` | Construir todas las plataformas | 15-20 min |
| `/build submit ios` | Enviar a TestFlight | 1-5 min |
| `/build update` | Actualización OTA en caliente | 1-2 min |

## 🔧 Requisitos previos

| Requisito | Propósito | Costo |
|-----------|-----------|-------|
| [Node.js](https://nodejs.org/) | Entorno de ejecución | Gratis |
| [Cuenta Expo](https://expo.dev/) | Construcciones en la nube | Gratis |
| [Apple Developer](https://developer.apple.com/) | Publicación iOS | $99/año |
| [Google Play Console](https://play.google.com/console/) | Publicación Android | $25 único |

## 🚀 Inicio rápido

```bash
# 1. Instalar EAS CLI
npm install -g eas-cli

# 2. Iniciar sesión en Expo
eas login

# 3. Inicializar en tu proyecto
cd your-expo-project
eas build:configure

# 4. Usa el comando /build en Claude Code
```

## ❓ Preguntas frecuentes

**¿Construcción muy lenta?** Usa `/build preview` para desarrollo diario, solo usa construcción en la nube al distribuir.

**¿Cómo actualizar una app publicada?** Actualizaciones pequeñas: `/build update`. Actualizaciones grandes: cambia versión, reconstruye y envía.

**¿Necesito Mac para construir iOS?** ¡No! Las construcciones EAS en la nube se ejecutan en servidores.

---

⭐ ¡Dale una estrella si te resulta útil!
