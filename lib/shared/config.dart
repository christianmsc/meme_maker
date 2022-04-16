import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get baseUrl => _get('BASE_URL');
  static String get basePublicUrl => _get('BASE_PUBLIC_URL');
  static String get apiHost => _get('API_HOST');
  static String get apiKey => _get('API_KEY');

  static String _get(String name) => dotenv.env[name] ?? '';
  //static int _getInt(String name) => int.parse(DotEnv().env[name]!);

}