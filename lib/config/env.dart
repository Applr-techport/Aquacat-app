import 'package:flutter/foundation.dart';

class Env {
  static const String _prodUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://aquacat-server-production.up.railway.app',
  );

  static String get apiUrl => kDebugMode ? 'http://192.168.0.149:3000' : _prodUrl;

  static const String appName = '냥냥워터';
  static const String version = '1.0.0';
}
