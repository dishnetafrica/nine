import 'package:flutter/material.dart';

class StarlinkPage extends StatelessWidget {
  const StarlinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dish Telemetry', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(label: Text('Uptime: 12h 33m')),
              Chip(label: Text('Down: 164.2 Mbps')),
              Chip(label: Text('Up: 18.8 Mbps')),
              Chip(label: Text('Latency: 43 ms')),
            ],
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
              child: Center(child: Text('Obstruction Map Placeholder')),
            ),
          ),
        ],
      ),
    );
  }
}
