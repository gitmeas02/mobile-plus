import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HttpClient extends http.BaseClient{
  HttpClient(this.navigatorKey);
  final http.Client _inner = http.Client();
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // You can add custom logic here (e.g., logging, modifying requests)
    return _inner.send(request);
  }
}