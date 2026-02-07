import 'api_client.dart';

class UispApiClient {
  UispApiClient(this._apiClient);

  final ApiClient _apiClient;

  Future<List<dynamic>> fetchDevices() async {
    final response = await _apiClient.get<List<dynamic>>('/nms/api/v2.1/devices');
    return response.data ?? <dynamic>[];
  }

  Future<List<dynamic>> fetchClients() async {
    final response = await _apiClient.get<List<dynamic>>('/crm/api/v1.0/clients');
    return response.data ?? <dynamic>[];
  }

  Future<List<dynamic>> fetchInvoices() async {
    final response = await _apiClient.get<List<dynamic>>('/crm/api/v1.0/invoices');
    return response.data ?? <dynamic>[];
  }
}
