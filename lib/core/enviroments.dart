import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroments {
  // Get base URL from .env file
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'http://localhost:8080';
  
  // Get environment type
  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';
  
  static bool get isDevelopment => environment == 'development';
  
  static bool get isProduction => environment == 'production';
}
