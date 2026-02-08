# Nine ISP Suite (Flutter)

Production-oriented Flutter app foundation for Starlink resellers and ISPs operating in low-connectivity regions.

## What is implemented

- Clean architecture structure split into `core`, `features`, and `shared` modules.
- Riverpod dependency injection + GoRouter shell navigation.
- Offline-first persistence with Hive for vouchers, customers, and offline queue.
- Retry-enabled Dio API client for unreliable links.
- Secure credential persistence using `flutter_secure_storage`.
- Feature scaffolds for:
  - Starlink local telemetry mode and controls entry points.
  - MikroTik and UISP integration pages.
  - Voucher generation (1-1000), local history, and QR payload data.
  - Customer local DB records with sync-ready repository pattern.

## Quick start (Android Studio / VS Code)

1. Install Flutter stable (3.22+), Android SDK, and Xcode (for iOS).
2. Clone this repo.
3. Run:

```bash
./bootstrap.sh
flutter run
```

4. For Android Studio:
   - Open this folder as a Flutter project.
   - Select an Android emulator/device (or iOS simulator on macOS).
   - Click **Run**.

## Kotlin daemon crash fix (your `flutter run` error)

If you see errors like `Could not connect to Kotlin compile daemon`:

1. Ensure you ran `./bootstrap.sh` once (it patches `android/gradle.properties` with safe Kotlin/JVM options).
2. Then run:

```bash
flutter clean
cd android && ./gradlew --stop && cd ..
flutter pub get
flutter run
```

3. If still failing, set JDK 17 for Flutter/Gradle:

```bash
flutter config --jdk-dir "/path/to/jdk-17"
flutter doctor -v
```

4. In Android Studio, verify:
   - **Gradle JDK = 17**
   - Kotlin plugin updated
   - No stale Gradle daemons running

## Project architecture

```text
lib/
├── main.dart
├── app_router.dart
├── core/
│   ├── constants/
│   ├── di/
│   ├── errors/
│   ├── network/
│   ├── services/
│   ├── storage/
│   └── theme/
├── features/
│   ├── auth/
│   ├── customers/
│   ├── dashboard/
│   ├── hotspot/
│   ├── mikrotik/
│   ├── settings/
│   ├── starlink/
│   ├── uisp/
│   └── voucher/
└── shared/
    └── widgets/
```

## Production hardening checklist (next)

- Wire real Starlink gRPC bridge/proxy for dish commands.
- Add full MikroTik CRUD repositories (firewall, queues, PPPoE, DHCP static leases).
- Add UISP pull/push sync jobs with conflict handling.
- Add PDF voucher rendering/printing and hotspot user push automation.
- Add unit/widget/integration test suites and CI pipelines.
