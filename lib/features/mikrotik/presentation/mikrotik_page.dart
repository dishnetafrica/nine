import 'package:flutter/material.dart';

class MikroTikPage extends StatelessWidget {
  const MikroTikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ListTile(title: Text('System Resources'), subtitle: Text('CPU 14% • RAM 42% • Uptime 3d 2h')),
        Divider(),
        ListTile(title: Text('Interfaces'), subtitle: Text('ether1, bridge, wlan1')),
        ListTile(title: Text('DHCP Leases'), subtitle: Text('53 active leases')),
        ListTile(title: Text('Queue Rules'), subtitle: Text('22 simple queues')),
      ],
    );
  }
}
