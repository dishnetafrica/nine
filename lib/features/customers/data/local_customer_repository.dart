import 'package:hive/hive.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/errors/exceptions.dart';
import '../domain/customer.dart';
import '../domain/customer_repository.dart';

class LocalCustomerRepository implements CustomerRepository {
  @override
  Future<Result<List<Customer>>> getCustomers() async {
    final box = await Hive.openBox<Map>(AppConstants.customersBox);
    final customers = box.values
        .map((item) => Customer.fromJson(item))
        .toList(growable: false)
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return Success(customers);
  }

  @override
  Future<Result<void>> upsertCustomer(Customer customer) async {
    final box = await Hive.openBox<Map>(AppConstants.customersBox);
    await box.put(customer.id, customer.toJson());
    return const Success<void>(null);
  }
}
