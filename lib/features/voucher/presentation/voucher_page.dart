import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../domain/voucher.dart';

final voucherListProvider = FutureProvider<List<Voucher>>((ref) async {
  final result = await ref.watch(voucherRepositoryProvider).getAll();
  return result.when(success: (data) => data, failure: (error) => throw error);
});

class VoucherPage extends ConsumerStatefulWidget {
  const VoucherPage({super.key});

  @override
  ConsumerState<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends ConsumerState<VoucherPage> {
  final _quantityController = TextEditingController(text: '20');
  final _ssidController = TextEditingController(text: 'Starlink-WiFi');
  final _passwordController = TextEditingController(text: 'changeme123');
  String _profile = '2 Hours';

  @override
  void dispose() {
    _quantityController.dispose();
    _ssidController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _generate() async {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final result = await ref.read(voucherRepositoryProvider).generateBatch(
          quantity: quantity,
          profile: _profile,
          wifiSsid: _ssidController.text,
          wifiPassword: _passwordController.text,
        );

    if (!mounted) return;

    result.when(
      success: (items) {
        ref.invalidate(voucherListProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Generated ${items.length} vouchers.')),
        );
      },
      failure: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final voucherList = ref.watch(voucherListProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SizedBox(
                width: 120,
                child: TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Qty 1-1000'),
                ),
              ),
              SizedBox(
                width: 140,
                child: DropdownButtonFormField<String>(
                  value: _profile,
                  items: const [
                    DropdownMenuItem(value: '2 Hours', child: Text('2 Hours')),
                    DropdownMenuItem(value: '24 Hours', child: Text('24 Hours')),
                    DropdownMenuItem(value: '5GB', child: Text('5GB')),
                    DropdownMenuItem(value: '20GB', child: Text('20GB')),
                  ],
                  onChanged: (value) => setState(() => _profile = value ?? _profile),
                ),
              ),
              SizedBox(
                width: 180,
                child: TextField(
                  controller: _ssidController,
                  decoration: const InputDecoration(labelText: 'WiFi SSID'),
                ),
              ),
              SizedBox(
                width: 180,
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'WiFi password'),
                ),
              ),
              FilledButton.icon(
                onPressed: _generate,
                icon: const Icon(Icons.qr_code),
                label: const Text('Generate batch'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Print templates: 58mm • 80mm • A4 grid • A4 list'),
            subtitle: Text('Generated vouchers are stored locally for offline usage.'),
          ),
          Expanded(
            child: voucherList.when(
              data: (items) => ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    leading: const Icon(Icons.confirmation_num_outlined),
                    title: Text(item.code),
                    subtitle: Text('${item.profile} • ${item.createdAt.toLocal()}'),
                    trailing: Text(item.syncedToMikroTik ? 'Synced' : 'Local'),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text(error.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
