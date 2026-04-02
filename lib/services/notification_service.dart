import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _plugin.initialize(settings);
    _initialized = true;
  }

  Future<void> requestPermission() async {
    await _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    await _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: true, sound: true);
  }

  /// Schedule daily reminders based on user's wake/sleep/meal times
  Future<void> scheduleReminders({
    required String wakeTime,
    required String sleepTime,
    required String mealTimes,
    required String displayName,
    String locale = 'ko',
  }) async {
    // Cancel all existing
    await _plugin.cancelAll();

    final msgs = _localizedMessages(locale);
    final name = displayName.isNotEmpty ? displayName : msgs['defaultName']!;
    final meals = mealTimes.split(',').map((m) => m.trim()).toList();

    final wake = _parseTime(wakeTime);
    final sleep = _parseTime(sleepTime);

    final reminders = <_Reminder>[
      _Reminder(id: 1, hour: wake.hour, minute: wake.minute,
          title: msgs['morningTitle']!, body: '$name, ${msgs['morningBody']!}'),
      if (meals.isNotEmpty) _Reminder(id: 2, hour: _parseTime(meals[0]).hour, minute: _parseTime(meals[0]).minute + 30,
          title: msgs['breakfastTitle']!, body: '$name, ${msgs['breakfastBody']!}'),
      if (meals.length > 1) _Reminder(id: 3, hour: _parseTime(meals[1]).hour, minute: _parseTime(meals[1]).minute + 30,
          title: msgs['lunchTitle']!, body: '$name, ${msgs['lunchBody']!}'),
      if (meals.length > 2) _Reminder(id: 4, hour: _parseTime(meals[2]).hour, minute: _parseTime(meals[2]).minute + 30,
          title: msgs['dinnerTitle']!, body: '$name, ${msgs['dinnerBody']!}'),
      _Reminder(id: 5, hour: (sleep.hour - 2) % 24, minute: sleep.minute,
          title: msgs['settlementTitle']!, body: '$name, ${msgs['settlementBody']!}'),
    ];

    for (final r in reminders) {
      await _scheduleDaily(r);
    }
  }

  Future<void> _scheduleDaily(_Reminder r) async {
    if (kIsWeb) return;
    try {
      final now = tz.TZDateTime.now(tz.local);
      var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, r.hour, r.minute);
      if (scheduled.isBefore(now)) {
        scheduled = scheduled.add(const Duration(days: 1));
      }

      await _plugin.zonedSchedule(
        r.id,
        r.title,
        r.body,
        scheduled,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'water_reminder',
            '물 마시기 알림',
            channelDescription: '냥냥워터 물 마시기 리마인더',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (_) {}
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  Map<String, String> _localizedMessages(String locale) {
    switch (locale) {
      case 'ja':
        return {
          'defaultName': 'あなた', 'morningTitle': '☀️ おはよう！',
          'morningBody': '起きた？お水を一杯飲もう！', 'breakfastTitle': '🍚 朝食後',
          'breakfastBody': 'お水も飲もうね！', 'lunchTitle': '🍱 昼食後',
          'lunchBody': 'お水の時間だよ！', 'dinnerTitle': '🌙 夕食後',
          'dinnerBody': 'お水を一杯どう？', 'settlementTitle': '🏆 今日の結果！',
          'settlementBody': '目標達成できたか確認しよう！',
        };
      case 'zh':
        return {
          'defaultName': '你', 'morningTitle': '☀️ 早上好！',
          'morningBody': '起床啦？喝一杯水吧！', 'breakfastTitle': '🍚 早餐后',
          'breakfastBody': '别忘了喝水哦！', 'lunchTitle': '🍱 午餐后',
          'lunchBody': '该喝水啦！', 'dinnerTitle': '🌙 晚餐后',
          'dinnerBody': '来杯水怎么样？', 'settlementTitle': '🏆 今日总结！',
          'settlementBody': '看看今天目标达成了没？',
        };
      case 'es':
        return {
          'defaultName': 'amigo', 'morningTitle': '☀️ ¡Buenos días!',
          'morningBody': '¡Empieza con un vaso de agua!', 'breakfastTitle': '🍚 Después del desayuno',
          'breakfastBody': '¡No olvides beber agua!', 'lunchTitle': '🍱 Después del almuerzo',
          'lunchBody': '¡Hora de beber agua!', 'dinnerTitle': '🌙 Después de cenar',
          'dinnerBody': '¿Qué tal un vaso de agua?', 'settlementTitle': '🏆 ¡Resumen del día!',
          'settlementBody': '¡Verifica si alcanzaste tu meta!',
        };
      case 'vi':
        return {
          'defaultName': 'bạn', 'morningTitle': '☀️ Chào buổi sáng!',
          'morningBody': 'Uống một ly nước nào!', 'breakfastTitle': '🍚 Sau bữa sáng',
          'breakfastBody': 'Đừng quên uống nước!', 'lunchTitle': '🍱 Sau bữa trưa',
          'lunchBody': 'Giờ uống nước rồi!', 'dinnerTitle': '🌙 Sau bữa tối',
          'dinnerBody': 'Một ly nước nhé?', 'settlementTitle': '🏆 Tổng kết hôm nay!',
          'settlementBody': 'Kiểm tra mục tiêu nào!',
        };
      case 'en':
        return {
          'defaultName': 'friend', 'morningTitle': '☀️ Good morning!',
          'morningBody': 'Start your day with a glass of water!', 'breakfastTitle': '🍚 After breakfast',
          'breakfastBody': 'Don\'t forget to hydrate!', 'lunchTitle': '🍱 After lunch',
          'lunchBody': 'Time for water!', 'dinnerTitle': '🌙 After dinner',
          'dinnerBody': 'How about a glass of water?', 'settlementTitle': '🏆 Daily check!',
          'settlementBody': 'Did you reach your goal today?',
        };
      default: // ko
        return {
          'defaultName': '주인님', 'morningTitle': '☀️ 좋은 아침!',
          'morningBody': '물 한 잔으로 시작하자!', 'breakfastTitle': '🍚 아침 식사 후',
          'breakfastBody': '밥 먹었으면 물도 마셔!', 'lunchTitle': '🍱 점심 식사 후',
          'lunchBody': '점심 잘 먹었어? 물 마실 시간이야~', 'dinnerTitle': '🌙 저녁 식사 후',
          'dinnerBody': '저녁 먹고 물 한 잔 어때?', 'settlementTitle': '🏆 오늘의 정산!',
          'settlementBody': '오늘 목표 달성했는지 확인해볼까?',
        };
    }
  }

  ({int hour, int minute}) _parseTime(String time) {
    final parts = time.split(':');
    return (hour: int.parse(parts[0]) % 24, minute: int.parse(parts[1]));
  }
}

class _Reminder {
  final int id;
  final int hour;
  final int minute;
  final String title;
  final String body;

  _Reminder({required this.id, required this.hour, required this.minute, required this.title, required this.body});
}
