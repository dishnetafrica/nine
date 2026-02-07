# Nine ISP Suite (Flutter)

Offline-first operations app for Starlink resellers and ISPs in African markets.

## Implemented foundation

- Clean architecture folder layout aligned to requested modules.
- Riverpod dependency injection and service wiring.
- GoRouter navigation with feature shells.
- API client with retry/backoff for unstable networks.
- Offline queue service using Hive local storage.
- Connectivity-aware sync workflow hooks.

## Getting started

```bash
flutter pub get
flutter run
```

## Next implementation priorities

1. Replace placeholder Starlink client with real gRPC-web/proxy layer.
2. Implement secure credential vault and setup wizard.
3. Build domain entities/repositories per feature with DTO mapping.
4. Add PDF voucher generation/thermal printer support.
5. Add background sync worker and conflict resolution strategies.
