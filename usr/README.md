# 3D Game UI Framework

A premium, cross-platform Flutter application providing the complete frontend interface for a 3D Battle Royale / FPS game. This framework includes a startup sequence, authentication flow, full lobby system, customized setting panels, and a comprehensive admin dashboard.

## Overview

Designed for landscape orientation and an immersive mode experience, this project features high-quality UI elements, blurred cinematic backgrounds, and complex overlay systems commonly found in modern mobile games. It is ready to be hooked up to a game engine (like Unity or Unreal) or used as a standalone companion app.

## Features & Flows

- **Startup Sequence**: 
  - `LogoScreen`: Cinematic fade and zoom animation for the game logo.
  - `LoadingScreen`: Double loading effect with background artwork.
- **Authentication**:
  - `LoginScreen`: High-quality UI with blurred background, supporting login via Guest, Google, Facebook, Twitter, and Apple.
- **Main Lobby**:
  - `HomeScreen`: 3D character placeholder, top bar for currencies, left menu for events/shop, right menu for modes/friends, and bottom navigation for inventory.
- **Player Profile**:
  - `ProfilePanel`: Displays Name, UID, Level, EXP, Rank, and Gallery stats (Solo, Duo, Squad). Includes tabs for match history, weapon stats, replays, and photo albums.
- **Shop & Monetization**:
  - `ShopPanel`: Features a Normal Shop (Bundles, Guns, Emotes, Vehicles, etc.), a Luck Royale system with gacha spins, and a top-up system for premium crystals and memberships.
- **Game Modes & Maps**:
  - `ModesPanel`: Selection for Battle Royale, Clash Squad, Loving Island, Custom Rooms, and Training. Includes map selection (Bermuda, Purgatory, Kalahari, etc.).
- **Settings & Customization**:
  - `SettingsPanel`: Detailed settings for account linking, sensitivity (General, Red Dot, Scopes, Free Look), custom HUD (2, 3, or 4 finger setups), auto-pickup rules, and graphics (Smooth to Max FPS).
- **Admin System**:
  - `AdminDashboard`: Hidden behind a password prompt in the Settings panel. Provides tools for Ban/Unban/Delete accounts, sending mail/gifts, granting V Badges, sending custom room tickets, and broadcasting server notices.

## Tech Stack

- **Framework**: Flutter (Dart)
- **UI Architecture**: Component-based with responsive layouts targeting landscape displays.
- **Navigation**: Dialog-based panel system for seamless in-lobby experiences.
- **State Management**: Stateful widgets (ready to be connected to Provider/Riverpod/Bloc).

## Setup & Run Instructions

1. Ensure you have the Flutter SDK installed.
2. Clone this repository.
3. Run `flutter pub get` to fetch dependencies.
4. Run `flutter run` on a device or emulator. The app is optimized for landscape viewing, so physical devices or wide emulator screens will provide the best experience.

## Deployment Notes

- For mobile deployments (iOS/Android), ensure device orientation is locked to `landscapeRight` and `landscapeLeft` in the native project settings, as the Flutter `SystemChrome` configuration requests immersive landscape mode.
- Assets used in this preview are fetched via network URLs. For production, bundle game assets locally.

---

### About CouldAI
This app was generated with [CouldAI](https://could.ai), the AI app builder for cross-platform apps. CouldAI turns prompts into real native iOS, Android, Web, and Desktop apps with autonomous AI agents that architect, build, test, deploy, and iterate production-ready applications.