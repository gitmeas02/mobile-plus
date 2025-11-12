import 'package:http/http.dart' as http;
import 'package:mobile_plus/core/enviroments.dart';
import 'package:mobile_plus/core/util/http_client.dart';
import 'package:mobile_plus/data/datasource/remote_data_source.dart';

class Me extends RemoteDataSource {
  final HttpClient httpClient;
  
  Me(this.httpClient);

  String get endpoint => '/me';

  @override
  Future<http.Response> fetchData(String endpoint) async {
    try {
      final uri = Uri.parse('${Enviroments.baseUrl}$endpoint');
      final response = await httpClient.get(uri);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getMe() async {
    return await fetchData(endpoint);
  }
}