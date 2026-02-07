import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final _nmsController = TextEditingController();
  final _crmController = TextEditingController();
  final _mikrotikController = TextEditingController();

  @override
  void dispose() {
    _nmsController.dispose();
    _crmController.dispose();
    _mikrotikController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final service = ref.read(secureCredentialsServiceProvider);
    await service.saveUispKeys(
      nmsKey: _nmsController.text,
      crmKey: _crmController.text,
    );
    await service.saveMikroTikCredentials(_mikrotikController.text);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Credentials stored securely.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Offline-first Mode'),
          subtitle: Text('All writes are queueable and sync when internet recovers.'),
        ),
        TextField(
          controller: _nmsController,
          decoration: const InputDecoration(labelText: 'UISP NMS API key'),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _crmController,
          decoration: const InputDecoration(labelText: 'UISP CRM API key'),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _mikrotikController,
          decoration: const InputDecoration(labelText: 'MikroTik credentials (encrypted payload)'),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: FilledButton(onPressed: _save, child: const Text('Save secure settings')),
        ),
      ],
    );
  }
}
