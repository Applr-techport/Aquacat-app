import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../widgets/aqua_cat_svg.dart';
import '../widgets/ad_banner.dart';
import '../services/api_service.dart';
import '../services/widget_service.dart';
import '../services/notification_service.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final ApiService _api = ApiService();

  int _totalMl = 0;
  int _goalMl = 2000;
  int _progress = 0;
  int _gauge = 0;
  String _catState = 'normal';
  List<dynamic> _logs = [];
  String _tip = '';
  String _displayName = '';
  bool _loading = true;
  bool _error = false;

  late AnimationController _progressAnim;
  double _animatedProgress = 0;

  @override
  void initState() {
    super.initState();
    _progressAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _loadData();
    _loadTip();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await _api.getProfile();
      setState(() => _displayName = profile['displayName'] ?? '');
      // Setup notifications
      await NotificationService().init();
      await NotificationService().requestPermission();
      await NotificationService().scheduleReminders(
        wakeTime: profile['wakeTime'] ?? '08:00',
        sleepTime: profile['sleepTime'] ?? '24:00',
        mealTimes: profile['mealTimes'] ?? '08:30,13:00,19:30',
        displayName: _displayName,
      );
    } catch (_) {}
  }

  @override
  void dispose() {
    _progressAnim.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final data = await _api.getToday();
      final newProgress = (data['progress'] ?? 0).toDouble();
      setState(() {
        _totalMl = data['totalMl'] ?? 0;
        _goalMl = data['goalMl'] ?? 2000;
        _progress = data['progress'] ?? 0;
        _gauge = data['gauge'] ?? 0;
        _catState = data['catState'] ?? 'normal';
        _logs = data['logs'] ?? [];
        _loading = false;
      });
      // Update home widget
      WidgetService.updateWidget(currentMl: _totalMl, goalMl: _goalMl, catMessage: "💧");
      // Animate progress
      final tween = Tween<double>(begin: _animatedProgress, end: newProgress / 100);
      _progressAnim.reset();
      tween.animate(CurvedAnimation(parent: _progressAnim, curve: Curves.easeOut))
        ..addListener(() {
          setState(() => _animatedProgress = tween.evaluate(_progressAnim));
        });
      _progressAnim.forward();
    } catch (e) {
      setState(() { _loading = false; _error = true; });
    }
  }

  Future<void> _loadTip() async {
    try {
      final locale = _ctx != null ? Localizations.localeOf(_ctx!).languageCode : 'ko';
      final tip = await _api.getDailyTip(locale: locale);
      setState(() => _tip = tip);
    } catch (_) {}
  }

  // --- Cat messages (l10n) ---
  List<String> _getMessages(AppLocalizations l, String state) {
    switch (state) {
      case 'normal': return [l.catMessageNormal1, l.catMessageNormal2, l.catMessageNormal3];
      case 'thirsty': return [l.catMessageThirsty1, l.catMessageThirsty2, l.catMessageThirsty3];
      case 'critical': return [l.catMessageCritical1, l.catMessageCritical2];
      case 'happy': return [l.catMessageHappy1, l.catMessageHappy2, l.catMessageHappy3];
      case 'perfect': return [l.catMessagePerfect1, l.catMessagePerfect2];
      default: return [l.catMessageNormal1, l.catMessageNormal2, l.catMessageNormal3];
    }
  }

  String _getRandomMessage(String state) {
    final l = AppLocalizations.of(_ctx!);
    if (l != null) {
      final msgs = _getMessages(l, state);
      return msgs[Random().nextInt(msgs.length)];
    }
    return '💧';
  }

  BuildContext? _ctx;

  String _getRandomReaction() {
    // Reactions are fun/unique per language - keep simple
    final l = AppLocalizations.of(_ctx!);
    final reactions = [
      l?.catMessageNormal1 ?? '🐱',
      l?.catMessageHappy1 ?? '😻',
      '냥~ 🐱', // universal
      '🐾',
    ];
    return reactions[Random().nextInt(reactions.length)];
  }

  Future<void> _drinkWater(int amount, {String drinkType = 'water'}) async {
    HapticFeedback.mediumImpact();
    try {
      await _api.logWater(amount, drinkType: drinkType);
      await _loadData();
      // Update home widget
      WidgetService.updateWidget(
        currentMl: _totalMl,
        goalMl: _goalMl,
        catMessage: AppLocalizations.of(context)?.catMessageNormal1 ?? "Drink water! 💧",
      );
      if (mounted) {
        _showCatMessage(_getRandomMessage(_catState), amount);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)?.noRecordToUndo ?? 'Failed')),
        );
      }
    }
  }

  OverlayEntry? _overlayEntry;

  void _showCatMessage(String message, int amount) {
    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (context) => _CatMessageOverlay(
        message: message,
        amount: amount,
        onDismiss: () {
          _overlayEntry?.remove();
          _overlayEntry = null;
        },
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  CatState get _currentCatState {
    switch (_catState) {
      case 'happy': return CatState.happy;
      case 'thirsty': return CatState.thirsty;
      case 'critical': return CatState.critical;
      case 'perfect': return CatState.perfect;
      default: return CatState.normal;
    }
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Scaffold(
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_off_rounded, size: 48, color: AppTheme.textHintFor(context)),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)?.connectionError ?? '연결할 수 없어요', style: TextStyle(fontSize: 16, color: AppTheme.textSecondaryFor(context))),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () { setState(() { _error = false; _loading = true; }); _loadData(); },
                      icon: const Icon(Icons.refresh),
                      label: Text(AppLocalizations.of(context)?.retry ?? '다시 시도'),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: _loadData,
                color: AppTheme.primary,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      _buildGreeting(),
                      const SizedBox(height: 12),
                      if (_tip.isNotEmpty) _buildTipCard(),
                      const SizedBox(height: 20),
                      _buildCharacterSection(),
                      const SizedBox(height: 20),
                      _buildAmountText(),
                      const SizedBox(height: 28),
                      _buildDrinkButtons(),
                      const SizedBox(height: 28),
                      _buildTodayLogs(),
                      const SizedBox(height: 16),
                      const AdBannerWidget(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildGreeting() {
    final now = DateTime.now();
    final hour = now.hour;
    String greeting;
    String emoji;
    final l = AppLocalizations.of(context);
    final name = _displayName.isNotEmpty ? '$_displayName, ' : '';
    if (hour < 6) {
      greeting = '$name${l?.greetingNight ?? "Good night"}'; emoji = '🌙';
    } else if (hour < 10) {
      greeting = '$name${l?.greetingMorning ?? "Good morning"}'; emoji = '☀️';
    } else if (hour < 12) {
      greeting = '$name${l?.greetingForenoon ?? "Good morning"}'; emoji = '💪';
    } else if (hour < 14) {
      greeting = '$name${l?.greetingLunch ?? "Lunch time"}'; emoji = '🍚';
    } else if (hour < 18) {
      greeting = '$name${l?.greetingAfternoon ?? "Good afternoon"}'; emoji = '🌤️';
    } else if (hour < 21) {
      greeting = '$name${l?.greetingEvening ?? "Good evening"}'; emoji = '🌆';
    } else {
      greeting = '$name${l?.greetingNight ?? "Good night"}'; emoji = '🌙';
    }

    final weekdays = [l?.weekMon ?? 'Mon', l?.weekTue ?? 'Tue', l?.weekWed ?? 'Wed', l?.weekThu ?? 'Thu', l?.weekFri ?? 'Fri', l?.weekSat ?? 'Sat', l?.weekSun ?? 'Sun'];
    final wd = weekdays[now.weekday - 1];
    final dateStr = l?.dateFormat(now.month.toString(), now.day.toString(), wd) ?? '${now.month}/${now.day} $wd';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateStr,
          style: TextStyle(fontSize: 12, color: AppTheme.textHintFor(context)),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Text(
              greeting,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.textPrimaryFor(context)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTipCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.primarySurfaceFor(context),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.primaryBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(child: Text('💡', style: TextStyle(fontSize: 16))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _tip,
              style: TextStyle(fontSize: 13, color: AppTheme.textSecondaryFor(context), height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterSection() {
    final stateColor = AppTheme.stateColor(_catState);

    return SizedBox(
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background glow
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  stateColor.withValues(alpha: 0.06),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Progress ring
          SizedBox(
            width: 260,
            height: 260,
            child: CircularProgressIndicator(
              value: _animatedProgress.clamp(0.0, 1.0),
              strokeWidth: 10,
              strokeCap: StrokeCap.round,
              backgroundColor: AppTheme.primarySurfaceFor(context),
              valueColor: AlwaysStoppedAnimation<Color>(
                _progress >= 100 ? AppTheme.gold : AppTheme.primary,
              ),
            ),
          ),
          // Character (tap to react)
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              _showCatMessage(_getRandomReaction(), 0);
            },
            child: AquaCatSvg(state: _currentCatState, size: 180),
          ),
          // Gauge badge
          Positioned(
            bottom: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                color: stateColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: stateColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                _catStateLabel(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _catStateLabel() {
    final l = AppLocalizations.of(_ctx!);
    switch (_catState) {
      case 'perfect': return '👑 ${l?.catPerfect ?? "완벽해!"} $_gauge%';
      case 'happy': return '😊 ${l?.catHappy ?? "좋아!"} $_gauge%';
      case 'thirsty': return '😿 ${l?.catThirsty ?? "목말라..."} $_gauge%';
      case 'critical': return '🥀 ${l?.catCritical ?? "위험!"} $_gauge%';
      default: return '🐱 ${l?.catNormal ?? "보통"} $_gauge%';
    }
  }

  Widget _buildAmountText() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '$_totalMl',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: AppTheme.textPrimaryFor(context)),
            ),
            Text(
              ' / ${_goalMl}ml',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppTheme.textHintFor(context)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '$_progress% 달성',
          style: TextStyle(
            fontSize: 14,
            color: _progress >= 100 ? AppTheme.gold : AppTheme.textSecondaryFor(context),
            fontWeight: _progress >= 100 ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildDrinkButtons() {
    final presets = [
      {'amount': 150, 'icon': Icons.local_cafe_rounded, 'label': '150ml'},
      {'amount': 250, 'icon': Icons.water_drop_rounded, 'label': '250ml'},
      {'amount': 350, 'icon': Icons.local_drink_rounded, 'label': '350ml'},
      {'amount': 500, 'icon': Icons.water_drop_outlined, 'label': '500ml'},
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: presets.map((p) {
            return _DrinkButton(
              icon: p['icon'] as IconData,
              label: p['label'] as String,
              onTap: () => _drinkWater(p['amount'] as int),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        // Custom amount + undo row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Custom amount
            GestureDetector(
              onTap: _showCustomAmountDialog,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppTheme.primarySurfaceFor(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add, size: 18, color: AppTheme.primary),
                    const SizedBox(width: 4),
                    Text(AppLocalizations.of(context)?.customAmount ?? '직접 입력', style: const TextStyle(fontSize: 13, color: AppTheme.primaryLight, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Undo last
            if (_logs.isNotEmpty)
              GestureDetector(
                onTap: _undoLast,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.danger.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.undo, size: 18, color: AppTheme.danger),
                      const SizedBox(width: 4),
                      Text(AppLocalizations.of(context)?.undo ?? '되돌리기', style: const TextStyle(fontSize: 13, color: AppTheme.danger, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _drinkTypes(AppLocalizations? l) => [
    {'type': 'water', 'icon': Icons.water_drop_rounded, 'label': l?.drinkTypeWater ?? '물'},
    {'type': 'coffee', 'icon': Icons.coffee_rounded, 'label': l?.drinkTypeCoffee ?? '커피'},
    {'type': 'tea', 'icon': Icons.emoji_food_beverage_rounded, 'label': l?.drinkTypeTea ?? '차'},
    {'type': 'juice', 'icon': Icons.local_drink_rounded, 'label': l?.drinkTypeJuice ?? '음료'},
    {'type': 'other', 'icon': Icons.liquor_rounded, 'label': l?.drinkTypeOther ?? '기타'},
  ];

  static IconData drinkIcon(String type) {
    const types = [
      {'type': 'water', 'icon': Icons.water_drop_rounded},
      {'type': 'coffee', 'icon': Icons.coffee_rounded},
      {'type': 'tea', 'icon': Icons.emoji_food_beverage_rounded},
      {'type': 'juice', 'icon': Icons.local_drink_rounded},
      {'type': 'other', 'icon': Icons.liquor_rounded},
    ];
    return (types.firstWhere((d) => d['type'] == type, orElse: () => types[0])['icon'] as IconData);
  }

  Future<void> _showCustomAmountDialog() async {
    final controller = TextEditingController();
    String selectedType = 'water';
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) => AlertDialog(
            title: Text(AppLocalizations.of(context)?.customAmountTitle ?? '직접 입력'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drink type chips
                Wrap(
                  spacing: 8,
                  children: _drinkTypes(AppLocalizations.of(context)).map((d) {
                    final isSelected = selectedType == d['type'];
                    return ChoiceChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(d['icon'] as IconData, size: 16, color: isSelected ? Colors.white : AppTheme.textSecondaryFor(context)),
                          const SizedBox(width: 4),
                          Text(d['label'] as String),
                        ],
                      ),
                      selected: isSelected,
                      selectedColor: AppTheme.primary,
                      onSelected: (_) => setDialogState(() => selectedType = d['type'] as String),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)?.customAmountHint ?? 'ml',
                    suffixText: 'ml',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: Text(AppLocalizations.of(context)?.cancel ?? '취소')),
              TextButton(
                onPressed: () {
                  final val = int.tryParse(controller.text);
                  if (val != null && val > 0 && val <= 2000) {
                    Navigator.pop(ctx, {'amount': val, 'type': selectedType});
                  }
                },
                child: Text(AppLocalizations.of(context)?.add ?? '추가'),
              ),
            ],
          ),
        );
      },
    );
    if (result != null) _drinkWater(result['amount'], drinkType: result['type']);
  }

  Future<void> _undoLast() async {
    if (_logs.isEmpty) return;
    final last = _logs.first;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.undoConfirm ?? '마지막 기록 취소'),
        content: Text('${last['amount']}ml 기록을 삭제할까요?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(AppLocalizations.of(context)?.cancel ?? '취소')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(AppLocalizations.of(context)?.delete ?? '삭제', style: const TextStyle(color: AppTheme.danger))),
        ],
      ),
    );
    if (confirm == true) {
      await _api.deleteLog(last['id']);
      _loadData();
    }
  }

  Widget _buildTodayLogs() {
    if (_logs.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(Icons.water_drop_outlined, size: 40, color: AppTheme.primaryBg),
            const SizedBox(height: 12),
            Text(
              '${AppLocalizations.of(context)?.noRecordYet ?? "아직 기록이 없어요"}\n💧',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.textHintFor(context), fontSize: 14, height: 1.5),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppLocalizations.of(context)?.todayRecord ?? '오늘 기록',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textPrimaryFor(context)),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.primarySurfaceFor(context),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${_logs.length}${AppLocalizations.of(context)?.cups ?? "잔"}',
                style: const TextStyle(fontSize: 12, color: AppTheme.primary, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: AppTheme.cardDecorationFor(context),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: _logs.take(10).map((log) {
              final time = DateTime.parse(log['loggedAt']).toLocal();
              final timeStr = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
              return Dismissible(
                key: Key(log['id']),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: AppTheme.danger.withValues(alpha: 0.1),
                  child: const Icon(Icons.delete_outline, color: AppTheme.danger),
                ),
                confirmDismiss: (_) async {
                  return await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(AppLocalizations.of(context)?.deleteRecord ?? '기록 삭제'),
                      content: Text(AppLocalizations.of(context)?.deleteRecordConfirm ?? '이 기록을 삭제할까요?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(AppLocalizations.of(context)?.cancel ?? '취소')),
                        TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(AppLocalizations.of(context)?.delete ?? '삭제', style: const TextStyle(color: AppTheme.danger))),
                      ],
                    ),
                  ) ?? false;
                },
                onDismissed: (_) async {
                  await _api.deleteLog(log['id']);
                  _loadData();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppTheme.dividerFor(context).withValues(alpha: 0.5))),
                  ),
                  child: Row(
                    children: [
                      Icon(drinkIcon(log['drinkType'] ?? 'water'), size: 18, color: AppTheme.primary),
                      const SizedBox(width: 10),
                      Text(timeStr, style: TextStyle(color: AppTheme.textHintFor(context), fontSize: 13)),
                      const Spacer(),
                      Text(
                        '${log['amount']}ml',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppTheme.textPrimaryFor(context)),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _DrinkButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrinkButton({required this.icon, required this.label, required this.onTap});

  @override
  State<_DrinkButton> createState() => _DrinkButtonState();
}

class _DrinkButtonState extends State<_DrinkButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: 74,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: Theme.of(context).brightness == Brightness.dark ? [] : (_pressed ? AppTheme.buttonShadow : AppTheme.cardShadow),
          ),
          child: Column(
            children: [
              Icon(widget.icon, size: 32, color: AppTheme.primary),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: TextStyle(fontSize: 12, color: AppTheme.textSecondaryFor(context), fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CatMessageOverlay extends StatefulWidget {
  final String message;
  final int amount;
  final VoidCallback onDismiss;

  const _CatMessageOverlay({required this.message, required this.amount, required this.onDismiss});

  @override
  State<_CatMessageOverlay> createState() => _CatMessageOverlayState();
}

class _CatMessageOverlayState extends State<_CatMessageOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, -0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismiss());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 8,
      left: 24,
      right: 24,
      child: SlideTransition(
        position: _slideAnim,
        child: FadeTransition(
          opacity: _fadeAnim,
          child: GestureDetector(
            onTap: () {
              _controller.reverse().then((_) => widget.onDismiss());
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppTheme.popupShadow,
                ),
                child: Row(
                  children: [
                    if (widget.amount > 0) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primarySurfaceFor(context),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '+${widget.amount}ml',
                          style: const TextStyle(fontSize: 13, color: AppTheme.primary, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Text(
                        widget.message,
                        style: TextStyle(fontSize: 14, color: AppTheme.textPrimaryFor(context)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
