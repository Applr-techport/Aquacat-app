import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';
import 'login_screen.dart';
import 'onboarding_screen.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    final loggedIn = await AuthService().isLoggedIn();
    if (!loggedIn) {
      _navigate(const LoginScreen());
      return;
    }

    try {
      final profile = await ApiService().getProfile();
      if (!mounted) return;

      if (profile['weight'] == null || profile['weight'] == 0) {
        _navigate(const OnboardingScreen());
      } else {
        _navigate(const MainScreen());
      }
    } catch (e) {
      debugPrint('Splash error: $e');
      _navigate(const LoginScreen());
    }
  }

  void _navigate(Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svg/happy.svg', width: 140, height: 140),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)?.appName ?? '아쿠아캣',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppTheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)?.loginSubtitle ?? '물 마시는 습관, 냥이와 함께!',
              style: TextStyle(fontSize: 14, color: AppTheme.textSecondaryFor(context)),
            ),
          ],
        ),
      ),
    );
  }
}
