# Thali Help — Ultra-simple Flutter MVP

This repository contains a minimal Flutter MVP app (`thali_help`) and a tiny REST backend to store help requests.

- Overview
- Flutter app (no auth). Patient enters name and phone once (stored via `SharedPreferences`).
- Simple Node/Express-like REST backend (file-based `db.json`) for storing requests.
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

Phone numbers
- The app saves an optional patient phone number along with the name. Requests include the phone number so providers can contact patients.

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

Run on Android with VS Code — step-by-step (for a non-technical user)

This section explains, in simple steps, how to run the Thali Help Android app from VS Code on a typical PC. Pick either "Use an Android emulator" or "Use an Android phone" depending on what you have.


Prerequisites (one-time setup)

- Install Flutter (stable): follow the Flutter "Get started" guide for your operating system at the official site. The guide shows how to download Flutter and add it to your PATH.
- Install VS Code from the official site. In VS Code you will install the Flutter and Dart extensions.
- Install Node.js (LTS) to run the backend.
- Optional but helpful: Android Studio. Android Studio provides the Android SDK, device emulator (AVD manager) and drivers which make running the app easier.

Helpful links (copy into a browser if needed):

- Flutter: https://flutter.dev/docs/get-started/install
- VS Code: https://code.visualstudio.com/
- Node.js: https://nodejs.org/

In VS Code: install the `Dart` and `Flutter` extensions (open Extensions view, search and click "Install").

Start the backend server (simple, local)
1. Open VS Code (or Terminal) and open the project folder `ThaliHelp`.

2. Open an integrated terminal in VS Code: View → Terminal.

3. Run these commands in the terminal to install the tiny backend dependency and start the server:

```bash
cd backend
npm install
node server.js
```

You should see a message like: `Thali Help backend running on http://localhost:3000`.

Note about networking between app and backend:
- If you run the Android app on an emulator, the emulator's special host `10.0.2.2` maps to your PC's `localhost`.
- If you run the app on a physical Android device, use your computer's local network IP (e.g. `http://192.168.1.42:3000`) and make sure your phone and PC are on the same Wi‑Fi network.

Set the API URL in the app
1. In VS Code open `lib/services/api_service.dart`.
2. Edit the `baseUrl` line near the top:

- For Android emulator (recommended):

```dart
static String baseUrl = 'http://10.0.2.2:3000';
```

- For a real Android phone (use your PC IP):

```dart
static String baseUrl = 'http://YOUR_PC_IP:3000';
```

Replace `YOUR_PC_IP` with the IP address of your computer. On macOS you can find it in System Settings → Network. On Windows use `ipconfig` in a terminal.

Run the Android app from VS Code (emulator)
1. Launch an Android emulator: In VS Code press Cmd/Ctrl+Shift+P and run `Flutter: Launch Emulator`, then pick a device (or create one via Android Studio AVD Manager). Wait for it to start.
2. In VS Code open the project folder and run `flutter pub get` (you can run this from the terminal or use the command palette `Flutter: Get Packages`).
3. Press F5 or click Run → Start Debugging. VS Code will build and install the app on the emulator.

Run the Android app from VS Code (physical device)
1. On your Android phone: enable Developer options and USB debugging (Settings → About → tap Build number 7 times to enable Developer options, then Settings → Developer options → USB debugging).
2. Connect the phone to your PC with USB and accept the prompt on the phone to allow USB debugging.
3. In VS Code run `flutter devices` in the terminal to ensure the phone is detected.
4. Run `flutter pub get`, then press F5 or Start Debugging in VS Code. The app will install on your phone.

Using the app
- On first open, the app asks for your name (and phone). Enter them and continue.
- Tap "Request Help" to create a request. Providers can view and mark requests as handled in the Provider/Admin screens (hidden routes).

Troubleshooting tips (common, simple fixes)
- If `flutter` is not found, close and reopen VS Code after installing Flutter, and make sure the Flutter SDK `bin` folder is in your PATH.
- If the emulator can't start, install Android Studio and create an AVD in AVD Manager, then retry `Flutter: Launch Emulator`.
- If the app shows connection errors when submitting requests, double-check `ApiService.baseUrl`:
	- Emulator → use `http://10.0.2.2:3000`
	- Real phone → use `http://YOUR_PC_IP:3000` and ensure both devices are on the same network and any firewall allows the port.
- If the backend didn't start: make sure you ran `npm install` inside `backend/` and then `node server.js`.

If you want, I can create a short video or GIF showing the exact keypresses in VS Code, or I can add a one-click `run_backend.sh` and `run_app_emulator.sh` script — tell me which you'd prefer.
