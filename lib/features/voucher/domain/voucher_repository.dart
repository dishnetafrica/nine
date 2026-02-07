import '../../../core/errors/exceptions.dart';
import 'voucher.dart';

abstract interface class VoucherRepository {
  Future<Result<List<Voucher>>> generateBatch({
    required int quantity,
    required String profile,
    required String wifiSsid,
    required String wifiPassword,
  });

  Future<Result<List<Voucher>>> getAll();
}
