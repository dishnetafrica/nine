import 'package:flutter/material.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ListTile(title: Text('Customers'), subtitle: Text('Local DB with UISP sync support')),
        ListTile(title: Text('Service Plans'), subtitle: Text('Map customers to speed/data plans')),
        ListTile(title: Text('Billing Snapshot'), subtitle: Text('Invoices and payment history')),
      ],
    );
  }
}
