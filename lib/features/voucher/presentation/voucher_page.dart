import 'package:flutter/material.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.qr_code),
            label: const Text('Generate batch vouchers'),
          ),
          const SizedBox(height: 16),
          const ListTile(
            title: Text('Supported print templates'),
            subtitle: Text('58mm thermal • 80mm thermal • A4 grid • A4 list'),
          ),
          const Expanded(
            child: Card(child: Center(child: Text('Voucher history list'))),
          ),
        ],
      ),
    );
  }
}
