import '../../../core/errors/exceptions.dart';
import 'customer.dart';

abstract interface class CustomerRepository {
  Future<Result<List<Customer>>> getCustomers();
  Future<Result<void>> upsertCustomer(Customer customer);
}
