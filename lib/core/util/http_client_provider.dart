import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_plus/core/util/http_client.dart';
import 'package:mobile_plus/router/router.dart';

final httpClientProvider = Provider<HttpClient>((ref){
  final navigatorKey = ref.watch(routerKeyProvider);
  return HttpClient(navigatorKey);
});