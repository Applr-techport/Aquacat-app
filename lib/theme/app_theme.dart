import 'package:flutter/material.dart';

class AppTheme {
  // Primary (물/하늘)
  static const Color primary = Color(0xFF289BDD);
  static const Color primaryLight = Color(0xFF41BDED);
  static const Color primarySoft = Color(0xFF7DD3F8);
  static const Color primaryBg = Color(0xFFACE7F6);
  static const Color primarySurface = Color(0xFFE0F5FD);
  static const Color primaryFaint = Color(0xFFF0FAFF);

  // Semantic
  static const Color success = Color(0xFF34D399);
  static const Color warning = Color(0xFFFBBF24);
  static const Color danger = Color(0xFFF87171);
  static const Color gold = Color(0xFFF59E0B);

  // Neutral
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color background = Color(0xFFF0FAFF);
  static const Color surface = Colors.white;

  // Shadows
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: primary.withValues(alpha: 0.08),
      blurRadius: 12,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: primary.withValues(alpha: 0.12),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get popupShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  // Card decoration
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: surface,
    borderRadius: BorderRadius.circular(16),
    boxShadow: cardShadow,
  );

  static BoxDecoration get highlightCard => BoxDecoration(
    gradient: const LinearGradient(
      colors: [primary, primaryLight],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(20),
  );

  // State colors
  static Color stateColor(String state) {
    switch (state) {
      case 'happy': return success;
      case 'thirsty': return warning;
      case 'critical': return danger;
      case 'perfect': return gold;
      default: return primary;
    }
  }

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    fontFamily: 'Pretendard',
    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: primaryLight,
      surface: surface,
    ),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: textPrimary),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surface,
      selectedItemColor: primary,
      unselectedItemColor: textHint,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 11),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );

  // Dark colors
  static const Color darkBg = Color(0xFF0F1724);
  static const Color darkSurface = Color(0xFF1A2332);
  static const Color darkCard = Color(0xFF1E2A3A);
  static const Color darkText = Color(0xFFE8ECF0);
  static const Color darkTextSecondary = Color(0xFF8B9BB0);
  static const Color darkDivider = Color(0xFF2A3A4E);

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Pretendard',
    colorScheme: ColorScheme.dark(
      primary: primaryLight,
      secondary: primarySoft,
      surface: darkSurface,
      onSurface: darkText,
    ),
    scaffoldBackgroundColor: darkBg,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: darkText,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: darkText),
    ),
    cardTheme: CardThemeData(
      color: darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkSurface,
      selectedItemColor: primaryLight,
      unselectedItemColor: darkTextSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 11),
    ),
    listTileTheme: const ListTileThemeData(
      textColor: darkText,
      iconColor: primaryLight,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: darkCard,
      titleTextStyle: const TextStyle(color: darkText, fontSize: 18, fontWeight: FontWeight.w600),
      contentTextStyle: const TextStyle(color: darkTextSecondary, fontSize: 14),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: darkSurface,
      filled: true,
      hintStyle: TextStyle(color: darkTextSecondary.withValues(alpha: 0.5)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: darkText),
      bodyMedium: TextStyle(color: darkText),
      bodySmall: TextStyle(color: darkTextSecondary),
      titleLarge: TextStyle(color: darkText),
      titleMedium: TextStyle(color: darkText),
      labelLarge: TextStyle(color: darkText),
    ),
    dividerColor: darkDivider,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLight,
        foregroundColor: darkBg,
        elevation: 0,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(primaryLight),
      trackColor: WidgetStateProperty.resolveWith((states) =>
        states.contains(WidgetState.selected) ? primaryLight.withValues(alpha: 0.3) : darkDivider),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: darkCard,
      contentTextStyle: TextStyle(color: darkText),
    ),
  );

  // Dark-aware card decoration
  static BoxDecoration cardDecorationFor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? darkCard : surface,
      borderRadius: BorderRadius.circular(16),
      boxShadow: isDark ? [] : cardShadow,
    );
  }

  // Dark-aware text colors
  static Color textPrimaryFor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkText : textPrimary;

  static Color textSecondaryFor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkTextSecondary : textSecondary;

  static Color textHintFor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkTextSecondary.withValues(alpha: 0.6) : textHint;

  static Color surfaceFor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkCard : surface;

  static Color primarySurfaceFor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? primaryLight.withValues(alpha: 0.1) : primarySurface;

  static Color dividerFor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkDivider : divider;
}
