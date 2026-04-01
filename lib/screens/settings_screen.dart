import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../services/api_service.dart';
import 'achievements_screen.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';
import '../services/purchase_service.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import 'privacy_policy_screen.dart';
import 'purchase_history_screen.dart';
import 'terms_screen.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ApiService _api = ApiService();
  final PurchaseService _purchase = PurchaseService();
  Map<String, dynamic>? _profile;
  bool _loading = true;
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _hapticEnabled = true;
  String _themeMode = 'system';
  String _language = '';
  bool _isPremium = false;
  StreamSubscription<bool>? _premiumSub;

  @override
  void initState() {
    super.initState();
    _isPremium = _purchase.isPremium;
    _premiumSub = _purchase.premiumStream.listen((v) {
      if (mounted) setState(() => _isPremium = v);
    });
    _loadProfile();
  }

  @override
  void dispose() {
    _premiumSub?.cancel();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await _api.getProfile();
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _profile = profile;
        _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
        _soundEnabled = prefs.getBool('sound_enabled') ?? true;
        _hapticEnabled = prefs.getBool('haptic_enabled') ?? true;
        _themeMode = prefs.getString('theme_mode') ?? 'system';
        _language = prefs.getString('app_language') ?? '';
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)?.settingsTitle ?? '설정')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildProfileSection(),
                const SizedBox(height: 24),
                _buildGoalSection(),
                const SizedBox(height: 24),
                _buildAlarmSection(),
                const SizedBox(height: 24),
                _buildAppSection(),
              ],
            ),
    );
  }

  Widget _buildProfileSection() {
    final l = AppLocalizations.of(context);
    return _buildSection(l?.profile ?? '프로필', [
      _buildTile(
        icon: Icons.person_outline,
        title: l?.nickname ?? '호칭',
        value: _profile?['displayName'] ?? (l?.notSet ?? '미설정'),
        onTap: () => _editText('displayName', l?.nickname ?? '호칭', _profile?['displayName'] ?? ''),
      ),
      _buildTile(
        icon: Icons.monitor_weight_outlined,
        title: l?.onboardingWeight ?? '체중',
        value: '${_profile?['weight'] ?? 0}kg',
        onTap: () => _editNumber('weight', '${AppLocalizations.of(context)?.onboardingWeight ?? "체중"} (kg)', (_profile?['weight'] ?? 70).toDouble()),
      ),
      _buildTile(
        icon: Icons.cake_outlined,
        title: l?.onboardingAgeGroup ?? '연령대',
        value: _profile?['ageGroup'] ?? '30s',
        onTap: () => _editAgeGroup(),
      ),
      _buildTile(
        icon: Icons.directions_run_outlined,
        title: l?.activityLevel ?? '활동량',
        value: _activityLabel(_profile?['activityLevel'] ?? 'normal'),
        onTap: () => _editActivity(),
      ),
    ]);
  }

  Widget _buildGoalSection() {
    return _buildSection(AppLocalizations.of(context)?.goal ?? '목표', [
      _buildTile(
        icon: Icons.water_drop,
        title: AppLocalizations.of(context)?.dailyGoal ?? '일일 목표',
        value: '${_profile?['goalMl'] ?? 2000}ml',
      ),
      _buildTile(
        icon: Icons.wb_sunny_outlined,
        title: AppLocalizations.of(context)?.wakeTime ?? '기상 시간',
        value: _profile?['wakeTime'] ?? '08:00',
        onTap: () => _editTime('wakeTime', '기상 시간', _profile?['wakeTime'] ?? '08:00'),
      ),
      _buildTile(
        icon: Icons.nights_stay_outlined,
        title: AppLocalizations.of(context)?.sleepTime ?? '취침 시간',
        value: _profile?['sleepTime'] ?? '24:00',
        onTap: () => _editTime('sleepTime', '취침 시간', _profile?['sleepTime'] ?? '24:00'),
      ),
    ]);
  }

  Widget _buildAlarmSection() {
    return _buildSection(AppLocalizations.of(context)?.notification ?? '알림', [
      _buildTile(
        icon: Icons.restaurant,
        title: AppLocalizations.of(context)?.mealTimes ?? '식사 시간',
        value: _profile?['mealTimes'] ?? '08:30,13:00,19:30',
        onTap: () => _editMealTimes(),
      ),
      ListTile(
        leading: const Icon(Icons.notifications_outlined, color: AppTheme.primary, size: 22),
        title: Text(AppLocalizations.of(context)?.notificationEnabled ?? '푸시 알림', style: const TextStyle(fontSize: 15)),
        trailing: Switch(
          value: _notificationsEnabled,
          onChanged: (v) async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('notifications_enabled', v);
            setState(() => _notificationsEnabled = v);
            if (v) {
              await NotificationService().scheduleReminders(
                wakeTime: _profile?['wakeTime'] ?? '08:00',
                sleepTime: _profile?['sleepTime'] ?? '24:00',
                mealTimes: _profile?['mealTimes'] ?? '08:30,13:00,19:30',
                displayName: _profile?['displayName'] ?? '',
              );
            } else {
              await NotificationService().cancelAll();
            }
          },
        ),
      ),
      ListTile(
        leading: const Icon(Icons.volume_up_outlined, color: AppTheme.primary, size: 22),
        title: Text(AppLocalizations.of(context)?.sound ?? '소리', style: const TextStyle(fontSize: 15)),
        trailing: Switch(
          value: _soundEnabled,
          onChanged: (v) async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('sound_enabled', v);
            setState(() => _soundEnabled = v);
          },
        ),
      ),
      ListTile(
        leading: const Icon(Icons.vibration, color: AppTheme.primary, size: 22),
        title: Text(AppLocalizations.of(context)?.vibration ?? '햅틱', style: const TextStyle(fontSize: 15)),
        trailing: Switch(
          value: _hapticEnabled,
          onChanged: (v) async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('haptic_enabled', v);
            setState(() => _hapticEnabled = v);
          },
        ),
      ),
    ]);
  }

  Widget _buildAppSection() {
    final la = AppLocalizations.of(context);
    return _buildSection(la?.settings ?? '앱', [
      _buildTile(
        icon: Icons.palette_outlined,
        title: la?.theme ?? '테마',
        value: _themeMode == 'light' ? (la?.themeLight ?? '라이트') : _themeMode == 'dark' ? (la?.themeDark ?? '다크') : (la?.themeSystem ?? '자동'),
        onTap: () => _editTheme(),
      ),
      _buildTile(
        icon: Icons.language,
        title: la?.language ?? '언어',
        value: _getLanguageName(),
        onTap: () => _editLanguage(),
      ),
      _buildTile(
        icon: Icons.refresh,
        title: la?.dataReset ?? '데이터 초기화',
        value: '',
        onTap: () => _resetData(),
      ),
      _buildPremiumTile(),
      _buildTile(
        icon: Icons.emoji_events_outlined,
        title: la?.achievements ?? '업적',
        value: '',
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AchievementsScreen())),
      ),
      _buildTile(
        icon: Icons.receipt_long_outlined,
        title: la?.purchaseHistory ?? '구매 내역',
        value: '',
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PurchaseHistoryScreen())),
      ),
      _buildTile(
        icon: Icons.description_outlined,
        title: la?.terms ?? '이용약관',
        value: '',
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsScreen())),
      ),
      _buildTile(
        icon: Icons.shield_outlined,
        title: la?.privacyPolicy ?? '개인정보처리방침',
        value: '',
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen())),
      ),
      _buildTile(
        icon: Icons.info_outline,
        title: la?.version ?? '버전',
        value: '1.0.0',
      ),
      _buildTile(
        icon: Icons.delete_forever_outlined,
        title: la?.deleteAccount ?? '계정 삭제',
        value: '',
        onTap: () => _deleteAccount(),
      ),
      ListTile(
        leading: const Icon(Icons.logout, color: Colors.red, size: 22),
        title: Text(AppLocalizations.of(context)?.logout ?? '로그아웃', style: const TextStyle(fontSize: 15, color: Colors.red)),
        onTap: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(AppLocalizations.of(context)?.logout ?? '로그아웃'),
              content: Text(AppLocalizations.of(context)?.logoutConfirm ?? '정말 로그아웃할까요?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(AppLocalizations.of(context)?.cancel ?? '취소')),
                TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(AppLocalizations.of(context)?.logout ?? '로그아웃', style: const TextStyle(color: Colors.red))),
              ],
            ),
          );
          if (confirm != true || !mounted) return;
          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();
          try { await AuthService().logout(); } catch (_) {}
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (_) => false,
            );
          }
        },
      ),
    ]);
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textSecondaryFor(context),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildPremiumTile() {
    if (_isPremium) {
      return _buildTile(
        icon: Icons.workspace_premium,
        title: AppLocalizations.of(context)?.premium ?? '프리미엄',
        value: '✅ ${AppLocalizations.of(context)?.removeAdsComplete ?? "광고 제거 완료"}',
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF289BDD), Color(0xFF1A6FA0)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.workspace_premium, color: Colors.white, size: 24),
        title: Text(AppLocalizations.of(context)?.removeAds ?? '광고 제거', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
        subtitle: Text(
          _purchase.available ? _purchase.price : '₩1,900',
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
        onTap: () => _showPurchaseDialog(),
      ),
    );
  }

  void _showPurchaseDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.removeAds ?? '광고 제거'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)?.removeAdsDesc ?? '${_purchase.available ? _purchase.price : "₩1,900"}으로 모든 광고를 영구 제거합니다.'),
            const SizedBox(height: 12),
            Text('• ${AppLocalizations.of(context)?.removeBannerAds ?? "배너 광고 제거"}', style: const TextStyle(fontSize: 13)),
            Text('• ${AppLocalizations.of(context)?.removeFullAds ?? "전면 광고 제거"}', style: const TextStyle(fontSize: 13)),
            Text('• ${AppLocalizations.of(context)?.permanentPurchase ?? "한 번 구매로 영구 적용"}', style: const TextStyle(fontSize: 13)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(context)?.cancel ?? '취소'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _purchase.buyRemoveAds();
            },
            child: Text(AppLocalizations.of(context)?.purchase ?? '구매하기'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _purchase.restorePurchases();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)?.restoringPurchase ?? '구매 내역을 복원하는 중...')),
                );
              }
            },
            child: Text(AppLocalizations.of(context)?.restorePurchase ?? '구매 복원'),
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primary, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: TextStyle(color: AppTheme.textSecondaryFor(context), fontSize: 14)),
          if (onTap != null) Icon(Icons.chevron_right, size: 20, color: AppTheme.textSecondaryFor(context)),
        ],
      ),
      onTap: onTap,
    );
  }

  String _activityLabel(String level) {
    final l = AppLocalizations.of(context);
    switch (level) {
      case 'low': return l?.onboardingActivityLow ?? '적음';
      case 'high': return l?.onboardingActivityHigh ?? '많음';
      default: return l?.onboardingActivityNormal ?? '보통';
    }
  }

  Future<void> _editText(String field, String label, String current) async {
    final controller = TextEditingController(text: current);
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(label),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(AppLocalizations.of(context)?.cancel ?? '취소')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: Text(AppLocalizations.of(context)?.save ?? '저장'),
          ),
        ],
      ),
    );
    if (result != null && result.isNotEmpty) {
      await _api.updateProfile({field: result});
      _loadProfile();
    }
  }

  Future<void> _editNumber(String field, String label, double current) async {
    final controller = TextEditingController(text: current.toInt().toString());
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(label),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(AppLocalizations.of(context)?.cancel ?? '취소')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: Text(AppLocalizations.of(context)?.save ?? '저장'),
          ),
        ],
      ),
    );
    if (result != null && result.isNotEmpty) {
      await _api.updateProfile({field: double.parse(result)});
      _loadProfile();
    }
  }

  Future<void> _editActivity() async {
    final current = _profile?['activityLevel'] ?? 'normal';
    final la = AppLocalizations.of(context);
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        String selected = current;
        return StatefulBuilder(
          builder: (ctx, setDialogState) => AlertDialog(
            title: Text(la?.activityLevel ?? '활동량'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                {'value': 'low', 'label': '${la?.onboardingActivityLow ?? "적음"} (${la?.activityLowDesc2 ?? "사무직, 재택"})', 'sub': la?.activityFormula('30') ?? '체중 × 30ml'},
                {'value': 'normal', 'label': '${la?.onboardingActivityNormal ?? "보통"} (${la?.activityNormalDesc2 ?? "일반 활동"})', 'sub': la?.activityFormula('33') ?? '체중 × 33ml'},
                {'value': 'high', 'label': '${la?.onboardingActivityHigh ?? "많음"} (${la?.activityHighDesc2 ?? "운동, 야외"})', 'sub': la?.activityFormula('40') ?? '체중 × 40ml'},
              ].map((opt) {
                return RadioListTile<String>(
                  value: opt['value']!,
                  groupValue: selected,
                  title: Text(opt['label']!, style: const TextStyle(fontSize: 14)),
                  subtitle: Text(opt['sub']!, style: const TextStyle(fontSize: 12)),
                  onChanged: (v) => setDialogState(() => selected = v!),
                );
              }).toList(),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: Text(AppLocalizations.of(context)?.cancel ?? '취소')),
              TextButton(onPressed: () => Navigator.pop(ctx, selected), child: Text(AppLocalizations.of(context)?.save ?? '저장')),
            ],
          ),
        );
      },
    );
    if (result != null) {
      await _api.updateProfile({'activityLevel': result});
      _loadProfile();
    }
  }

  Future<void> _editMealTimes() async {
    final current = (_profile?['mealTimes'] ?? '08:30,13:00,19:30').split(',');
    final breakfast = TextEditingController(text: current[0].trim());
    final lunch = TextEditingController(text: current.length > 1 ? current[1].trim() : '13:00');
    final dinner = TextEditingController(text: current.length > 2 ? current[2].trim() : '19:30');
    
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.mealTimes ?? '식사 시간'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: breakfast, decoration: InputDecoration(labelText: AppLocalizations.of(context)?.breakfast ?? '아침', hintText: '08:30')),
            const SizedBox(height: 8),
            TextField(controller: lunch, decoration: InputDecoration(labelText: AppLocalizations.of(context)?.lunch ?? '점심', hintText: '13:00')),
            const SizedBox(height: 8),
            TextField(controller: dinner, decoration: InputDecoration(labelText: AppLocalizations.of(context)?.dinner ?? '저녁', hintText: '19:30')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(AppLocalizations.of(context)?.cancel ?? '취소')),
          TextButton(onPressed: () => Navigator.pop(ctx, '${breakfast.text},${lunch.text},${dinner.text}'), child: Text(AppLocalizations.of(context)?.save ?? '저장')),
        ],
      ),
    );
    if (result != null) {
      await _api.updateProfile({'mealTimes': result});
      _loadProfile();
    }
  }

  Future<void> _editAgeGroup() async {
    final l = AppLocalizations.of(context);
    final current = _profile?['ageGroup'] ?? '30s';
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        String selected = current;
        final options = {
          '20s': l?.onboardingAge20s ?? '20대',
          '30s': l?.onboardingAge30s ?? '30대',
          '40s': l?.onboardingAge40s ?? '40대',
          '50+': l?.onboardingAge50plus ?? '50+',
        };
        return StatefulBuilder(
          builder: (ctx, setDialogState) => AlertDialog(
            title: Text(l?.onboardingAgeGroup ?? '연령대'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: options.entries.map((e) => RadioListTile<String>(
                value: e.key,
                groupValue: selected,
                title: Text(e.value),
                onChanged: (v) => setDialogState(() => selected = v!),
              )).toList(),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l?.cancel ?? '취소')),
              TextButton(onPressed: () => Navigator.pop(ctx, selected), child: Text(l?.save ?? '저장')),
            ],
          ),
        );
      },
    );
    if (result != null && result != current) {
      await _api.updateProfile({'ageGroup': result});
      _loadProfile();
    }
  }

  static const _languages = [
    {'code': '', 'name': '자동 (시스템)', 'flag': '🌐'},
    {'code': 'ko', 'name': '한국어', 'flag': '🇰🇷'},
    {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
    {'code': 'ja', 'name': '日本語', 'flag': '🇯🇵'},
    {'code': 'zh', 'name': '中文', 'flag': '🇨🇳'},
    {'code': 'es', 'name': 'Español', 'flag': '🇪🇸'},
    {'code': 'vi', 'name': 'Tiếng Việt', 'flag': '🇻🇳'},
  ];

  String _getLanguageName() {
    if (_language.isEmpty) return AppLocalizations.of(context)?.themeSystem ?? '자동';
    final lang = _languages.firstWhere((l) => l['code'] == _language, orElse: () => _languages[0]);
    return '${lang['flag']} ${lang['name']}';
  }

  Future<void> _editLanguage() async {
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        String selected = _language;
        return StatefulBuilder(
          builder: (ctx, setDialogState) => AlertDialog(
            title: const Text('언어 / Language'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: _languages.map((lang) => RadioListTile<String>(
                  value: lang['code']!,
                  groupValue: selected,
                  title: Text('${lang['flag']} ${lang['name']}'),
                  onChanged: (v) => setDialogState(() => selected = v!),
                )).toList(),
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: Text(AppLocalizations.of(context)?.cancel ?? '취소')),
              TextButton(onPressed: () => Navigator.pop(ctx, selected), child: Text(AppLocalizations.of(context)?.save ?? '저장')),
            ],
          ),
        );
      },
    );
    if (result != null) {
      setState(() => _language = result);
      if (result.isEmpty) {
        // System default
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('app_language');
        if (mounted) {
          AquaCatApp.setLocale(context, WidgetsBinding.instance.platformDispatcher.locale);
        }
      } else {
        AquaCatApp.setLocale(context, Locale(result));
      }
    }
  }

  Future<void> _editTheme() async {
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        String selected = _themeMode;
        return StatefulBuilder(
          builder: (ctx, setDialogState) => AlertDialog(
            title: Text(AppLocalizations.of(context)?.theme ?? '테마'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(value: 'system', groupValue: selected, title: Text(AppLocalizations.of(context)?.themeSystem ?? '자동 (시스템)'), onChanged: (v) => setDialogState(() => selected = v!)),
                RadioListTile<String>(value: 'light', groupValue: selected, title: Text(AppLocalizations.of(context)?.themeLight ?? '라이트'), onChanged: (v) => setDialogState(() => selected = v!)),
                RadioListTile<String>(value: 'dark', groupValue: selected, title: Text(AppLocalizations.of(context)?.themeDark ?? '다크'), onChanged: (v) => setDialogState(() => selected = v!)),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: Text(AppLocalizations.of(context)?.cancel ?? '취소')),
              TextButton(onPressed: () => Navigator.pop(ctx, selected), child: Text(AppLocalizations.of(context)?.save ?? '저장')),
            ],
          ),
        );
      },
    );
    if (result != null) {
      setState(() => _themeMode = result);
      final mode = switch (result) { 'light' => ThemeMode.light, 'dark' => ThemeMode.dark, _ => ThemeMode.system };
      AquaCatApp.setThemeMode(context, mode);
    }
  }

  Future<void> _resetData() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.dataReset ?? '데이터 초기화'),
        content: Text(AppLocalizations.of(context)?.resetConfirm ?? '모든 물 마시기 기록이 삭제됩니다.\n프로필 정보는 유지됩니다.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(AppLocalizations.of(context)?.cancel ?? '취소')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(AppLocalizations.of(context)?.reset ?? '초기화', style: const TextStyle(color: Colors.red))),
        ],
      ),
    );
    if (confirm == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)?.resetNotSupported ?? '데이터 초기화는 서버 API 추가 후 지원됩니다.')));
    }
  }

  Future<void> _deleteAccount() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.deleteAccount ?? '계정 삭제'),
        content: Text(AppLocalizations.of(context)?.deleteAccountConfirm ?? '모든 데이터가 영구 삭제됩니다.\n정말 삭제하시겠습니까?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(AppLocalizations.of(context)?.cancel ?? '취소')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(AppLocalizations.of(context)?.delete ?? '삭제', style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirm == true) {
      try {
        await _api.deleteAccount();
        await AuthService().logout();
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (_) => false,
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)?.deleteAccountFailed ?? '계정 삭제에 실패했습니다.')),
          );
        }
      }
    }
  }

  Future<void> _editTime(String field, String label, String current) async {
    final times = field == 'wakeTime'
        ? ['05:00', '05:30', '06:00', '06:30', '07:00', '07:30', '08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00']
        : ['21:00', '21:30', '22:00', '22:30', '23:00', '23:30', '24:00', '00:30', '01:00', '01:30', '02:00'];
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        String selected = times.contains(current) ? current : times[times.length ~/ 2];
        return StatefulBuilder(
          builder: (ctx, setDialogState) => AlertDialog(
            title: Text(label),
            content: SizedBox(
              height: 300,
              width: 200,
              child: ListView.builder(
                itemCount: times.length,
                itemBuilder: (_, i) => RadioListTile<String>(
                  value: times[i],
                  groupValue: selected,
                  title: Text(times[i]),
                  onChanged: (v) => setDialogState(() => selected = v!),
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: Text(AppLocalizations.of(context)?.cancel ?? '취소')),
              TextButton(onPressed: () => Navigator.pop(ctx, selected), child: Text(AppLocalizations.of(context)?.save ?? '저장')),
            ],
          ),
        );
      },
    );
    if (result != null) {
      await _api.updateProfile({field: result});
      _loadProfile();
    }
  }
}
