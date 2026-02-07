import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ListTile(title: Text('Offline-first Mode'), subtitle: Text('Enabled with background sync queue')),
        ListTile(title: Text('Secure Storage'), subtitle: Text('Credentials in keychain/keystore')),
        ListTile(title: Text('API Endpoints'), subtitle: Text('Starlink local, MikroTik REST, UISP cloud')),
      ],
    );
  }
}
