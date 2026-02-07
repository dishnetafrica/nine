import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/customers/data/local_customer_repository.dart';
import '../../features/customers/domain/customer_repository.dart';
import '../../features/voucher/data/local_voucher_repository.dart';
import '../../features/voucher/domain/voucher_repository.dart';
import '../network/api_client.dart';
import '../network/mikrotik_api_client.dart';
import '../network/starlink_dish_client.dart';
import '../network/uisp_api_client.dart';
import '../services/connectivity_service.dart';
import '../services/notification_service.dart';
import '../services/offline_sync_service.dart';
import '../services/secure_credentials_service.dart';

final dioProvider = Provider<Dio>((ref) => Dio());
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(dio: ref.watch(dioProvider));
});

final starlinkDishClientProvider = Provider<StarlinkDishClient>(
  (ref) => const StarlinkDishClient(),
);

final mikroTikApiClientProvider = Provider<MikroTikApiClient>((ref) {
  return MikroTikApiClient(ref.watch(apiClientProvider));
});

final uispApiClientProvider = Provider<UispApiClient>((ref) {
  return UispApiClient(ref.watch(apiClientProvider));
});

final connectivityProvider = Provider<Connectivity>((ref) => Connectivity());

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService(ref.watch(connectivityProvider));
});

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => const NotificationService(),
);

final offlineSyncServiceProvider = Provider<OfflineSyncService>((ref) {
  return OfflineSyncService(
    connectivityService: ref.watch(connectivityServiceProvider),
    notificationService: ref.watch(notificationServiceProvider),
  );
});

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

final secureCredentialsServiceProvider = Provider<SecureCredentialsService>((ref) {
  return SecureCredentialsService(ref.watch(secureStorageProvider));
});

final voucherRepositoryProvider = Provider<VoucherRepository>(
  (ref) => LocalVoucherRepository(),
);

final customerRepositoryProvider = Provider<CustomerRepository>(
  (ref) => LocalCustomerRepository(),
);
