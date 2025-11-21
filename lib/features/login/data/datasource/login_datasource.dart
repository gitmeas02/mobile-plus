import 'dart:convert';

import 'package:mobile_plus/core/enviroments.dart';
import 'package:mobile_plus/core/util/http_client.dart';
import 'package:mobile_plus/data/datasource/remote_data_source.dart';
import 'package:mobile_plus/features/login/data/dto/login_request.dart';

class LoginDatasource extends RemoteDataSource<Map<String, dynamic>> {
  final HttpClient httpClient;
  final String endpoint = '/auth/login';
  
  LoginDatasource(this.httpClient);
  
  @override
  Future<Map<String, dynamic>> fetchData(String endpoint) async {
    throw UnimplementedError('Use login method instead');
  }

  Future<Map<String, dynamic>> login(LoginRequest request) async {
    try {
      final url = Uri.parse('${Enviroments.baseUrl}$endpoint');
      final response = await httpClient.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Login failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}