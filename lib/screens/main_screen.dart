import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'home_screen.dart';
import 'stats_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  int _refreshCounter = 0;

  Widget _buildScreen(int index) {
    switch (index) {
      case 0: return HomeScreen(key: ValueKey('home_$_refreshCounter'));
      case 1: return StatsScreen(key: ValueKey('stats_$_refreshCounter'));
      case 2: return const SettingsScreen();
      default: return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      body: _buildScreen(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() {
          if (i == _currentIndex && i != 2) _refreshCounter++;
          _currentIndex = i;
        }),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home_rounded), label: l?.home ?? '홈'),
          BottomNavigationBarItem(icon: const Icon(Icons.bar_chart_rounded), label: l?.stats ?? '통계'),
          BottomNavigationBarItem(icon: const Icon(Icons.settings_rounded), label: l?.settings ?? '설정'),
        ],
      ),
    );
  }
}
