import 'package:flutter/material.dart';

class UispPage extends StatelessWidget {
  const UispPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ListTile(title: Text('NMS API'), subtitle: Text('Sites, devices, outages, statistics')),
        ListTile(title: Text('CRM API'), subtitle: Text('Clients, services, invoices, payments, tickets')),
        ListTile(title: Text('Authentication'), subtitle: Text('Dual key support (NMS + CRM)')),
      ],
    );
  }
}
