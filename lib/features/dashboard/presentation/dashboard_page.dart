import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _StatusCard(title: 'Connectivity', value: 'Online', detail: 'Last sync: just now'),
        _StatusCard(title: 'Starlink Dish', value: 'Healthy', detail: 'Latency 43 ms • Packet loss 0.01%'),
        _StatusCard(title: 'MikroTik Router', value: 'Reachable', detail: 'CPU 14% • Memory 42%'),
        _StatusCard(title: 'Offline Queue', value: '2 pending', detail: 'Auto-sync on reconnect'),
      ],
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
