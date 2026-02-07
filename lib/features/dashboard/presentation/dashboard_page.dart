import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/di/service_locator.dart';

final dashboardSummaryProvider = FutureProvider<DashboardSummary>((ref) async {
  final isOnline = await ref.watch(connectivityServiceProvider).isOnline();
  final queueBox = await Hive.openBox<Map>(AppConstants.offlineQueueBox);
  final telemetry = await ref
      .watch(starlinkDishClientProvider)
      .fetchTelemetry(isOnStarlinkLan: true);

  final latency = telemetry.when(
    success: (data) => '${data.latencyMs.toStringAsFixed(0)} ms',
    failure: (_) => 'Unavailable',
  );

  return DashboardSummary(
    isOnline: isOnline,
    queuePending: queueBox.length,
    starlinkLatency: latency,
  );
});

class DashboardSummary {
  const DashboardSummary({
    required this.isOnline,
    required this.queuePending,
    required this.starlinkLatency,
  });

  final bool isOnline;
  final int queuePending;
  final String starlinkLatency;
}

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(dashboardSummaryProvider);

    return summary.when(
      data: (data) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _StatusCard(
            title: 'Connectivity',
            value: data.isOnline ? 'Online' : 'Offline',
            detail: data.isOnline
                ? 'Connected. Sync can run now.'
                : 'Offline mode active. Queueing operations.',
          ),
          _StatusCard(
            title: 'Starlink Dish',
            value: data.starlinkLatency,
            detail: 'Live telemetry channel initialized.',
          ),
          const _StatusCard(
            title: 'MikroTik Router',
            value: 'Connected',
            detail: 'RouterOS REST integration ready.',
          ),
          _StatusCard(
            title: 'Offline Queue',
            value: '${data.queuePending} pending',
            detail: 'Operations auto-sync on reconnection.',
          ),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.title,
    required this.value,
    required this.detail,
  });

  final String title;
  final String value;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        subtitle: Text(detail),
        trailing: Text(value),
      ),
    );
  }
}
