import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/di/service_locator.dart';
import '../domain/customer.dart';

final customersProvider = FutureProvider<List<Customer>>((ref) async {
  final result = await ref.watch(customerRepositoryProvider).getCustomers();
  return result.when(success: (data) => data, failure: (error) => throw error);
});

class CustomersPage extends ConsumerStatefulWidget {
  const CustomersPage({super.key});

  @override
  ConsumerState<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends ConsumerState<CustomersPage> {
  Future<void> _addCustomer() async {
    final now = DateTime.now().toUtc();
    final customer = Customer(
      id: const Uuid().v4(),
      name: 'New customer ${now.millisecond}',
      phone: '+254700000000',
      plan: '10 Mbps Unlimited',
      balance: 0,
      updatedAt: now,
    );

    await ref.read(customerRepositoryProvider).upsertCustomer(customer);
    ref.invalidate(customersProvider);
  }

  @override
  Widget build(BuildContext context) {
    final customers = ref.watch(customersProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              FilledButton.icon(
                onPressed: _addCustomer,
                icon: const Icon(Icons.person_add_alt_1_outlined),
                label: const Text('Add customer'),
              ),
              const SizedBox(width: 8),
              const Text('Local DB + UISP/UCRM sync-ready model'),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: customers.when(
              data: (items) => ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text('${item.phone} • ${item.plan}'),
                      trailing: Text('KES ${item.balance.toStringAsFixed(2)}'),
                    ),
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
