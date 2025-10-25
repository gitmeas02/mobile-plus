import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClickMeService {
  static const _seenKey = 'seen_welcome';

  Future<bool> getSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_seenKey) ?? false;
  }

  Future<void> setSeen(bool seen) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_seenKey, seen);
  }
}

final clickMeServiceProvider = Provider<ClickMeService>((ref) {
  return ClickMeService();
});