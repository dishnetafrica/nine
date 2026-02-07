import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';

final starlinkLocalModeProvider = StateProvider<bool>((ref) => true);

final starlinkTelemetryProvider = FutureProvider.autoDispose((ref) {
  final localMode = ref.watch(starlinkLocalModeProvider);
  return ref
      .watch(starlinkDishClientProvider)
      .fetchTelemetry(isOnStarlinkLan: localMode);
});

class StarlinkPage extends ConsumerWidget {
  const StarlinkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localMode = ref.watch(starlinkLocalModeProvider);
    final telemetryAsync = ref.watch(starlinkTelemetryProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Dish Telemetry', style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              const Text('Local mode'),
              Switch(
                value: localMode,
                onChanged: (value) => ref.read(starlinkLocalModeProvider.notifier).state = value,
              ),
            ],
          ),
          const SizedBox(height: 12),
          telemetryAsync.when(
            data: (result) => result.when(
              success: (data) => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(label: Text('Uptime: ${data.uptimeSeconds ~/ 3600}h')),
                  Chip(label: Text('Down: ${data.downlinkMbps} Mbps')),
                  Chip(label: Text('Up: ${data.uplinkMbps} Mbps')),
                  Chip(label: Text('Latency: ${data.latencyMs} ms')),
                  Chip(label: Text('Loss: ${(data.packetLoss * 100).toStringAsFixed(2)}%')),
                ],
              ),
              failure: (error) => Text(error.message),
            ),
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text(error.toString()),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              OutlinedButton(onPressed: () {}, child: const Text('Reboot dish')),
              OutlinedButton(onPressed: () {}, child: const Text('Stow / Unstow')),
              FilledButton(onPressed: () {}, child: const Text('Run speed test')),
            ],
          ),
          const SizedBox(height: 16),
          const Expanded(
            child: Card(
              child: Center(child: Text('Obstruction map + history chart integration point')),
            ),
          ),
        ],
      ),
    );
  }
}
