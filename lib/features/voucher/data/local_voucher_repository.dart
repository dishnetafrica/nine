import 'dart:math';

import 'package:hive/hive.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/errors/exceptions.dart';
import '../domain/voucher.dart';
import '../domain/voucher_repository.dart';

class LocalVoucherRepository implements VoucherRepository {
  static const _alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  @override
  Future<Result<List<Voucher>>> generateBatch({
    required int quantity,
    required String profile,
    required String wifiSsid,
    required String wifiPassword,
  }) async {
    if (quantity < 1 || quantity > 1000) {
      return const Failure(
        ValidationException('Voucher batch quantity must be between 1 and 1000.'),
      );
    }

    final box = await Hive.openBox<Map>(AppConstants.vouchersBox);
    final now = DateTime.now().toUtc();
    final vouchers = List.generate(
      quantity,
      (_) {
        final code = _generateCode();
        final qrPayload = 'WIFI:T:WPA;S:$wifiSsid;P:$wifiPassword;;';
        return Voucher(
          code: code,
          profile: profile,
          createdAt: now,
          qrPayload: qrPayload,
        );
      },
    );

    for (final voucher in vouchers) {
      await box.put(voucher.code, voucher.toJson());
    }

    return Success(vouchers);
  }

  @override
  Future<Result<List<Voucher>>> getAll() async {
    final box = await Hive.openBox<Map>(AppConstants.vouchersBox);
    final list = box.values
        .map((item) => Voucher.fromJson(item))
        .toList(growable: false)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return Success(list);
  }

  String _generateCode() {
    final random = Random.secure();
    return List.generate(
      10,
      (_) => _alphabet[random.nextInt(_alphabet.length)],
    ).join();
  }
}
