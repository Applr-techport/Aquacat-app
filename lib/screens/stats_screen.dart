import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final ApiService _api = ApiService();

  List<dynamic> _weekly = [];
  List<dynamic> _calendar = [];
  int _streak = 0;
  bool _loading = true;
  late String _currentMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentMonth = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final results = await Future.wait([
        _api.getWeekly(),
        _api.getCalendar(_currentMonth),
        _api.getStreak(),
      ]);
      setState(() {
        _weekly = results[0] as List<dynamic>;
        _calendar = results[1] as List<dynamic>;
        _streak = (results[2] as Map<String, dynamic>)['streak'] ?? 0;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)?.statsTitle ?? '통계')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWeeklySummary(),
                    _buildStreakCard(),
                    const SizedBox(height: 24),
                    _buildWeeklyChart(),
                    const SizedBox(height: 24),
                    _buildCalendarSection(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildWeeklySummary() {
    if (_weekly.isEmpty) return const SizedBox.shrink();
    final totalWeek = _weekly.fold<int>(0, (sum, d) => sum + ((d['totalMl'] as int?) ?? 0));
    final daysWithData = _weekly.where((d) => ((d['totalMl'] as int?) ?? 0) > 0).length;
    final avg = daysWithData > 0 ? (totalWeek / daysWithData).round() : 0;
    final achieved = _weekly.where((d) => (d['achieved'] as bool?) ?? false).length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: Theme.of(context).brightness == Brightness.dark ? [] : [BoxShadow(color: AppTheme.primary.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem(AppLocalizations.of(context)?.dailyAverage ?? '일 평균', '${avg}ml', Icons.water_drop_rounded),
          Container(width: 1, height: 36, color: AppTheme.dividerFor(context)),
          _statItem(AppLocalizations.of(context)?.achievedDays ?? '달성일', '$achieved/${_weekly.length}', Icons.check_circle_outline),
          Container(width: 1, height: 36, color: AppTheme.dividerFor(context)),
          _statItem(AppLocalizations.of(context)?.totalIntake ?? '총 섭취', '${(totalWeek / 1000).toStringAsFixed(1)}L', Icons.local_drink_rounded),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppTheme.primary),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textPrimaryFor(context))),
        Text(label, style: TextStyle(fontSize: 11, color: AppTheme.textSecondaryFor(context))),
      ],
    );
  }

  Widget _buildStreakCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, AppTheme.primaryLight],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(
            '🔥',
            style: TextStyle(fontSize: _streak > 0 ? 36 : 28),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)?.consecutiveDays(_streak.toString()) ?? '$_streak일 연속 달성',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                _streak > 0 ? (AppLocalizations.of(context)?.keepGoing ?? '대단해! 계속 이어가자!') : (AppLocalizations.of(context)?.startToday ?? '오늘부터 시작해봐!'),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart() {
    if (_weekly.isEmpty) return const SizedBox.shrink();

    final maxMl = _weekly.fold<int>(0, (max, d) {
      final total = (d['totalMl'] as int?) ?? 0;
      return total > max ? total : max;
    });
    final chartMax = ((maxMl > 0 ? maxMl : 2000) * 1.2).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)?.weeklySummary ?? '주간 섭취량', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textPrimaryFor(context))),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              maxY: chartMax,
              barGroups: _weekly.asMap().entries.map((e) {
                final d = e.value;
                final total = ((d['totalMl'] as int?) ?? 0).toDouble();
                final achieved = (d['achieved'] as bool?) ?? false;
                return BarChartGroupData(
                  x: e.key,
                  barRods: [
                    BarChartRodData(
                      toY: total,
                      width: 24,
                      color: achieved ? Colors.amber : AppTheme.primary,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                    ),
                  ],
                );
              }).toList(),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (_) => AppTheme.surfaceFor(context),
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      '${rod.toY.toInt()}ml',
                      TextStyle(
                        color: AppTheme.textPrimaryFor(context),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final ll = AppLocalizations.of(context);
                      final days = [ll?.weekMon ?? 'M', ll?.weekTue ?? 'T', ll?.weekWed ?? 'W', ll?.weekThu ?? 'T', ll?.weekFri ?? 'F', ll?.weekSat ?? 'S', ll?.weekSun ?? 'S'];
                      if (value.toInt() < _weekly.length) {
                        final date = _weekly[value.toInt()]['date'] as String;
                        final dt = DateTime.parse(date);
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            days[dt.weekday - 1],
                            style: TextStyle(fontSize: 12, color: AppTheme.textSecondaryFor(context)),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: _weekly.where((d) => ((d['totalMl'] as int?) ?? 0) > 0).isEmpty ? 0 :
                        _weekly.where((d) => ((d['totalMl'] as int?) ?? 0) > 0)
                            .fold<int>(0, (s, d) => s + ((d['totalMl'] as int?) ?? 0)) /
                            _weekly.where((d) => ((d['totalMl'] as int?) ?? 0) > 0).length,
                    color: AppTheme.danger.withValues(alpha: 0.5),
                    strokeWidth: 1,
                    dashArray: [5, 5],
                    label: HorizontalLineLabel(
                      show: true,
                      alignment: Alignment.topRight,
                      style: const TextStyle(fontSize: 10, color: AppTheme.danger),
                      labelResolver: (line) => AppLocalizations.of(context)?.average ?? 'Avg',
                    ),
                  ),
                ],
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarSection() {
    final calMap = <String, Map<String, dynamic>>{};
    for (final c in _calendar) {
      calMap[c['date']] = Map<String, dynamic>.from(c);
    }

    final year = int.parse(_currentMonth.split('-')[0]);
    final month = int.parse(_currentMonth.split('-')[1]);
    final firstDay = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final startWeekday = firstDay.weekday; // 1=Mon

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left, color: AppTheme.textSecondaryFor(context)),
              onPressed: () {
                final m = month == 1 ? 12 : month - 1;
                final y = month == 1 ? year - 1 : year;
                setState(() => _currentMonth = '$y-${m.toString().padLeft(2, '0')}');
                _loadData();
              },
            ),
            Text(
              AppLocalizations.of(context)?.yearMonth(year.toString(), month.toString()) ?? '$year년 $month월',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textPrimaryFor(context)),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right, color: AppTheme.textSecondaryFor(context)),
              onPressed: () {
                final m = month == 12 ? 1 : month + 1;
                final y = month == 12 ? year + 1 : year;
                setState(() => _currentMonth = '$y-${m.toString().padLeft(2, '0')}');
                _loadData();
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [AppLocalizations.of(context)?.weekMon ?? 'M', AppLocalizations.of(context)?.weekTue ?? 'T', AppLocalizations.of(context)?.weekWed ?? 'W', AppLocalizations.of(context)?.weekThu ?? 'T', AppLocalizations.of(context)?.weekFri ?? 'F', AppLocalizations.of(context)?.weekSat ?? 'S', AppLocalizations.of(context)?.weekSun ?? 'S']
              .map((d) => SizedBox(
                    width: 36,
                    child: Text(d, textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppTheme.textSecondaryFor(context))),
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        // Calendar grid
        ...List.generate(((daysInMonth + startWeekday - 2) ~/ 7) + 1, (week) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (weekday) {
                final dayNum = week * 7 + weekday + 1 - (startWeekday - 1);
                if (dayNum < 1 || dayNum > daysInMonth) {
                  return const SizedBox(width: 36, height: 36);
                }
                final dateStr = '$_currentMonth-${dayNum.toString().padLeft(2, '0')}';
                final data = calMap[dateStr];
                final pct = data?['percentage'] ?? 0;

                Color dotColor;
                if (data == null) {
                  dotColor = Colors.transparent;
                } else if (pct >= 100) {
                  dotColor = Colors.amber;
                } else if (pct >= 70) {
                  dotColor = Colors.orange[300]!;
                } else {
                  dotColor = Colors.red[300]!;
                }

                final isToday = dateStr == DateTime.now().toIso8601String().substring(0, 10);

                return SizedBox(
                  width: 36,
                  height: 36,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: isToday ? BoxDecoration(
                          color: AppTheme.primary.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ) : null,
                        alignment: Alignment.center,
                        child: Text(
                          '$dayNum',
                          style: TextStyle(
                            fontSize: 13,
                            color: isToday
                                ? AppTheme.primaryLight
                                : AppTheme.textPrimaryFor(context),
                            fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                          ),
                        ),
                      ),
                      if (data != null)
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: dotColor,
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          );
        }),
      ],
    );
  }
}
