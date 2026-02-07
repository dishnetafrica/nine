class AppConstants {
  const AppConstants._();

  static const appName = 'Nine ISP Suite';
  static const starlinkDishHost = '192.168.100.1';
  static const starlinkGrpcPortPrimary = 9200;
  static const starlinkGrpcPortSecondary = 9201;

  static const offlineQueueBox = 'offline_queue';
  static const customersBox = 'customers';
  static const vouchersBox = 'vouchers';
  static const appSettingsBox = 'app_settings';

  static const defaultRequestTimeoutSeconds = 15;
  static const maxRetryAttempts = 3;
}
