
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_plus/core/util/http_client_provider.dart';
import 'package:mobile_plus/features/home/data/datasource/me.dart';
import 'package:mobile_plus/features/home/data/model/user_model.dart';


final homeProvider = Provider<Me>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return Me(httpClient);
});

final userDataProvider = FutureProvider<UserModel>((ref) async {
  final me = ref.watch(homeProvider);
  final response = await me.getMe();
  
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return UserModel.fromMap(data);
  } else {
    throw Exception('Failed to load user data: ${response.statusCode}');
  }
});