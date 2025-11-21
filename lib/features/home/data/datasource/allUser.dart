import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_plus/core/enviroments.dart';
import 'package:mobile_plus/core/util/http_client.dart';
import 'package:mobile_plus/data/datasource/remote_data_source.dart';

class Alluser extends RemoteDataSource {
  final HttpClient httpClient;
  
  Alluser(this.httpClient);

  String get endpoint => '/users/all';

  @override
  Future<http.Response> fetchData(String endpoint) async {
    try {
      final uri = Uri.parse('${Enviroments.baseUrl}$endpoint');
      debugPrint('Fetching from: $uri');
      final response = await httpClient.get(uri);
      debugPrint('Response Status: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');
      return response;
    } catch (e) {
      debugPrint('Error fetching data: $e');
      rethrow;
    }
  }

  Future<http.Response> getAllUsers() async {
    return await fetchData(endpoint);
  }
}