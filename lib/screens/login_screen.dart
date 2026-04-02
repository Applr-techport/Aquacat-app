import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/env.dart';
import '../l10n/app_localizations.dart';
import 'privacy_policy_screen.dart';
import 'terms_screen.dart';
import '../theme/app_theme.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'onboarding_screen.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;

  Future<void> _devLogin() async {
    setState(() => _loading = true);
    try {
      final dio = Dio(BaseOptions(baseUrl: Env.apiUrl));
      final res = await dio.post('/auth/dev-login', data: {'email': 'dev@aquacat.test'});
      final token = res.data['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      if (!mounted) return;

      final profile = await ApiService().getProfile();
      if (!mounted) return;

      if (profile['weight'] == null || profile['weight'] == 0) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _loginWithApple() async {
    setState(() => _loading = true);
    try {
      final success = await AuthService().signInWithApple();
      if (!mounted) return;

      if (success) {
        final profile = await ApiService().getProfile();
        if (!mounted) return;

        if (profile['weight'] == null || profile['weight'] == 0) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)?.login ?? 'Login failed')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() => _loading = true);
    try {
      final success = await AuthService().signInWithGoogle();
      if (!mounted) return;

      if (success) {
        final profile = await ApiService().getProfile();
        if (!mounted) return;

        if (profile['weight'] == null || profile['weight'] == 0) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)?.login ?? 'Login failed')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),
              SvgPicture.asset('assets/svg/happy.svg', width: 200, height: 200),
              const SizedBox(height: 32),
              Text(
                l?.appName ?? '냥냥워터',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textPrimaryFor(context),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l?.loginSubtitle ?? '물 마시는 습관, 냥이와 함께!',
                style: TextStyle(fontSize: 16, color: AppTheme.textSecondaryFor(context)),
              ),
              const Spacer(flex: 3),
              // Google Login
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _loginWithGoogle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: AppTheme.textPrimaryFor(context),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                  ),
                  child: _loading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.g_mobiledata, size: 28, color: Colors.red),
                            const SizedBox(width: 8),
                            Text(l?.loginWithGoogle ?? 'Google로 시작하기',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                ),
              ),
              if (Platform.isIOS) ...[
              const SizedBox(height: 16),
              // Apple Login
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _loginWithApple,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                    foregroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.apple, size: 24),
                      const SizedBox(width: 8),
                      Text(l?.loginWithApple ?? 'Apple로 시작하기',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              ],
              const SizedBox(height: 12),
              if (kDebugMode)
                TextButton(
                  onPressed: _loading ? null : _devLogin,
                  child: Text('🐱 ${l?.devLogin ?? "개발용 로그인"}', style: const TextStyle(color: Colors.grey)),
                ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsScreen())),
                    child: Text(l?.terms ?? '이용약관', style: TextStyle(fontSize: 11, color: AppTheme.primary, decoration: TextDecoration.underline)),
                  ),
                  Text(' · ', style: TextStyle(fontSize: 11, color: AppTheme.textHintFor(context))),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen())),
                    child: Text(l?.privacyPolicy ?? '개인정보처리방침', style: TextStyle(fontSize: 11, color: AppTheme.primary, decoration: TextDecoration.underline)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
