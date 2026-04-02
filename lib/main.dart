import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'services/ad_service.dart';
import 'services/api_service.dart';
import 'services/purchase_service.dart';
import 'services/widget_service.dart';
import 'theme/app_theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WidgetService.init();
  if (!kIsWeb) {
    await AdService().init();
    await PurchaseService().init();
  }
  runApp(const AquaCatApp());
}

class AquaCatApp extends StatefulWidget {
  const AquaCatApp({super.key});

  static void setThemeMode(BuildContext context, ThemeMode mode) {
    context.findAncestorStateOfType<_AquaCatAppState>()?.setThemeMode(mode);
  }

  static void setLocale(BuildContext context, Locale locale) {
    context.findAncestorStateOfType<_AquaCatAppState>()?.setLocale(locale);
  }

  @override
  State<AquaCatApp> createState() => _AquaCatAppState();
}

class _AquaCatAppState extends State<AquaCatApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _loadLocale();
    ApiService.onAuthError = () {
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (_) => false,
      );
    };
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme_mode') ?? 'system';
    setState(() {
      _themeMode = switch (theme) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
    });
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('app_language');
    if (lang != null) {
      setState(() => _locale = Locale(lang));
    }
  }

  void setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      _ => 'system',
    });
    setState(() => _themeMode = mode);
  }

  void setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_language', locale.languageCode);
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: '냥냥워터',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SplashScreen(),
    );
  }
}
