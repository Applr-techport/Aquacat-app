import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

class WidgetService {
  static const _appGroupId = 'group.com.aquacat.water';
  static const _androidName = 'WaterWidgetProvider';
  static const _iOSName = 'WaterWidget';

  static Future<void> init() async {
    if (kIsWeb) return;
    HomeWidget.setAppGroupId(_appGroupId);
  }

  static Future<void> updateWidget({
    required int currentMl,
    required int goalMl,
    required String catMessage,
  }) async {
    if (kIsWeb) return;
    final percent = goalMl > 0 ? (currentMl / goalMl * 100).clamp(0, 100).toInt() : 0;

    await HomeWidget.saveWidgetData<int>('currentMl', currentMl);
    await HomeWidget.saveWidgetData<int>('goalMl', goalMl);
    await HomeWidget.saveWidgetData<int>('percent', percent);
    await HomeWidget.saveWidgetData<String>('catMessage', catMessage);

    await HomeWidget.updateWidget(
      androidName: _androidName,
      iOSName: _iOSName,
    );
  }
}
