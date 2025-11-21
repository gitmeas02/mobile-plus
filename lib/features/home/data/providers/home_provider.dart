
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_plus/core/util/http_client_provider.dart';
import 'package:mobile_plus/features/home/data/datasource/allUser.dart';
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

// Grt all users
final allUsersProvider = FutureProvider<List<UserModel>>((ref) async {
  final httpClient = ref.watch(httpClientProvider);
  final allUser = Alluser(httpClient);
  
  try {
    final response = await allUser.getAllUsers();
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((user) => UserModel.fromMap(user)).toList();
    } else {
      throw Exception('Failed to load users: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    print('Error in allUsersProvider: $e');
    rethrow;
  }
});