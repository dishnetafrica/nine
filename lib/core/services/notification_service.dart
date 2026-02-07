class NotificationService {
  const NotificationService();

  Future<void> initialize() async {
    // Hook for flutter_local_notifications integration.
  }

  Future<void> showSyncCompleted(int processedCount) async {
    // Hook for local success notification.
    processedCount;
  }
}
