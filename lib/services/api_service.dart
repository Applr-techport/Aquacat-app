import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/env.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  static VoidCallback? onAuthError;

  late final Dio _dio;
  Dio get dio => _dio;

  ApiService._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: Env.apiUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('jwt_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('jwt_token');
          // Navigate to login - uses global navigator key
          ApiService.onAuthError?.call();
        }
        return handler.next(error);
      },
    ));
  }

  // Auth
  Future<Map<String, dynamic>> googleLogin(String idToken) async {
    final res = await _dio.post('/auth/google', data: {'idToken': idToken});
    return res.data;
  }

  // User
  Future<Map<String, dynamic>> getProfile() async {
    final res = await _dio.get('/user/profile');
    return Map<String, dynamic>.from(res.data);
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    final res = await _dio.patch('/user/profile', data: data);
    return Map<String, dynamic>.from(res.data);
  }

  Future<Map<String, dynamic>> completeOnboarding(Map<String, dynamic> data) async {
    final res = await _dio.post('/user/onboarding', data: data);
    return Map<String, dynamic>.from(res.data);
  }

  // Water
  Future<Map<String, dynamic>> logWater(int amount, {String drinkType = 'water'}) async {
    final res = await _dio.post('/water/log', data: {'amount': amount, 'drinkType': drinkType});
    return Map<String, dynamic>.from(res.data);
  }

  Future<void> deleteLog(String id) async {
    await _dio.delete('/water/log/$id');
  }

  Future<Map<String, dynamic>> getToday() async {
    final res = await _dio.get('/water/today');
    return Map<String, dynamic>.from(res.data);
  }

  Future<List<dynamic>> getCalendar(String month) async {
    final res = await _dio.get('/water/calendar', queryParameters: {'month': month});
    return res.data;
  }

  Future<List<dynamic>> getWeekly() async {
    final res = await _dio.get('/water/weekly');
    return res.data;
  }

  Future<Map<String, dynamic>> getStreak() async {
    final res = await _dio.get('/water/streak');
    return Map<String, dynamic>.from(res.data);
  }

  Future<void> deleteAccount() async {
    await _dio.delete('/user/account');
  }

  // Achievements
  Future<List<dynamic>> getAchievements() async {
    final res = await _dio.get('/achievement');
    return res.data;
  }

  // Health
  Future<String> getDailyTip({String locale = 'ko'}) async {
    final res = await _dio.get('/health/tip', queryParameters: {'locale': locale});
    return res.data['tip'];
  }
}
