import 'package:flutter/material.dart';

class HotspotPage extends StatelessWidget {
  const HotspotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ListTile(title: Text('Hotspot Users'), subtitle: Text('Create/update/suspend hotspot users.')),
        ListTile(title: Text('Profiles'), subtitle: Text('Rate limits, shared users, idle timeout.')),
        ListTile(title: Text('Active Sessions'), subtitle: Text('Disconnect live users in real time.')),
      ],
    );
  }
}
