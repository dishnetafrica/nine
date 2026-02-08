import 'api_client.dart';

class MikroTikApiClient {
  MikroTikApiClient(this._apiClient);

  final ApiClient _apiClient;

  Future<Map<String, dynamic>> fetchSystemResources() async {
    final response = await _apiClient.get<Map<String, dynamic>>('/rest/system/resource');
    return response.data ?? <String, dynamic>{};
  }

  Future<List<dynamic>> fetchDhcpLeases() async {
    final response = await _apiClient.get<List<dynamic>>('/rest/ip/dhcp-server/lease');
    return response.data ?? <dynamic>[];
  }

  Future<void> createHotspotUser(Map<String, dynamic> payload) async {
    await _apiClient.post<void>('/rest/ip/hotspot/user', data: payload);
  }
}
