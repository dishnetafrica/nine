import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../constants/app_constants.dart';
import '../storage/offline_operation.dart';
import 'connectivity_service.dart';
import 'notification_service.dart';

typedef SyncHandler = Future<void> Function(OfflineOperation operation);

class OfflineSyncService {
  OfflineSyncService({
    required ConnectivityService connectivityService,
    required NotificationService notificationService,
  })  : _connectivityService = connectivityService,
        _notificationService = notificationService;

  final ConnectivityService _connectivityService;
  final NotificationService _notificationService;
  final Uuid _uuid = const Uuid();

  Future<void> enqueue({
    required String type,
    required Map<String, dynamic> payload,
  }) async {
    final box = await Hive.openBox<Map>(AppConstants.offlineQueueBox);
    final op = OfflineOperation(
      id: _uuid.v4(),
      type: type,
      payload: payload,
      createdAt: DateTime.now().toUtc(),
    );
    await box.put(op.id, op.toJson());
  }

  Future<int> syncPending(SyncHandler handler) async {
    if (!await _connectivityService.isOnline()) {
      return 0;
    }

    final box = await Hive.openBox<Map>(AppConstants.offlineQueueBox);
    final keys = box.keys.toList(growable: false);
    var processed = 0;

    for (final key in keys) {
      final raw = box.get(key);
      if (raw == null) {
        continue;
      }

      final op = OfflineOperation.fromJson(raw);
      await handler(op);
      await box.delete(key);
      processed++;
    }

    if (processed > 0) {
      await _notificationService.showSyncCompleted(processed);
    }

    return processed;
  }
}
