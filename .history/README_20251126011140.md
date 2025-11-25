# Thali Help — Ultra-simple Flutter MVP

This repository contains a minimal Flutter MVP app (`thali_help`) and a tiny REST backend to store help requests.

Overview
- Flutter app (no auth). Patient enters name once (stored via `SharedPreferences`).
- Simple Node/Express-like REST backend (file-based `db.json`) for storing requests.

Notes
- I couldn't find the pasted logo in the workspace. Add your logo at `assets/logo.png` (same name) to use it in the app.
- The REST backend is intentionally tiny and file-based for easy local testing.

Running backend (Node, requires Node.js >= 14)

1. Open a terminal and go to `backend/`.
2. Install dependencies and run:

```bash
cd backend
npm install
node server.js
```

By default the server runs on `http://localhost:3000`. For Android emulator use `http://10.0.2.2:3000`.

Running Flutter app

1. Make sure Flutter SDK (stable) is installed and in PATH.
2. From repo root run:

```bash
flutter pub get
flutter run
```

If using an Android emulator, set API base URL in `lib/services/api_service.dart` to `http://10.0.2.2:3000`.

Future roadmap
- Add real authentication for providers and admins
- Move backend to hosted REST API (or Firebase) and add TLS
- Add push notifications for incoming requests
- Improve UI, add filtering and map-based locations
