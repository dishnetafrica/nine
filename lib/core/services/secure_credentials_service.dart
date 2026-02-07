import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCredentialsService {
  SecureCredentialsService(this._storage);

  final FlutterSecureStorage _storage;

  static const _mikrotikKey = 'mikrotik_credentials';
  static const _uispNmsKey = 'uisp_nms_key';
  static const _uispCrmKey = 'uisp_crm_key';

  Future<void> saveMikroTikCredentials(String value) {
    return _storage.write(key: _mikrotikKey, value: value);
  }

  Future<String?> readMikroTikCredentials() {
    return _storage.read(key: _mikrotikKey);
  }

  Future<void> saveUispKeys({required String nmsKey, required String crmKey}) async {
    await _storage.write(key: _uispNmsKey, value: nmsKey);
    await _storage.write(key: _uispCrmKey, value: crmKey);
  }
}
