import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  List<dynamic> _achievements = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await ApiService().getAchievements();
      setState(() { _achievements = data; _loading = false; });
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  String _localized(Map<String, dynamic>? map, String locale) {
    if (map == null) return '';
    return (map[locale] ?? map['en'] ?? map['ko'] ?? '').toString();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final unlocked = _achievements.where((a) => a['unlocked'] == true).length;
    final total = _achievements.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('🏆 ${AppLocalizations.of(context)?.stats ?? "Achievements"}'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: AppTheme.textPrimaryFor(context),
        elevation: 0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Progress header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.primaryLight]),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Text('🏆', style: TextStyle(fontSize: 40)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$unlocked / $total',
                                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: total > 0 ? unlocked / total : 0,
                                  backgroundColor: Colors.white24,
                                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                                  minHeight: 6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Achievement grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _achievements.length,
                    itemBuilder: (context, i) {
                      final a = _achievements[i];
                      final isUnlocked = a['unlocked'] == true;
                      return GestureDetector(
                        onTap: () => _showDetail(a, locale),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isUnlocked
                                ? Theme.of(context).colorScheme.surface
                                : (Theme.of(context).brightness == Brightness.dark ? Colors.grey[850] : Colors.grey[100]),
                            borderRadius: BorderRadius.circular(16),
                            border: isUnlocked
                                ? Border.all(color: AppTheme.primary.withValues(alpha: 0.3))
                                : null,
                            boxShadow: isUnlocked ? AppTheme.cardShadow : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isUnlocked ? (a['icon'] ?? '🏆') : '🔒',
                                style: TextStyle(fontSize: 32, color: isUnlocked ? null : Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  _localized(a['title'], locale),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isUnlocked
                                        ? AppTheme.textPrimaryFor(context)
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  void _showDetail(dynamic a, String locale) {
    final isUnlocked = a['unlocked'] == true;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(isUnlocked ? (a['icon'] ?? '🏆') : '🔒', style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            Text(
              _localized(a['title'], locale),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              _localized(a['description'], locale),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            if (isUnlocked && a['unlockedAt'] != null) ...[
              const SizedBox(height: 12),
              Text(
                _formatDate(a['unlockedAt']),
                style: TextStyle(fontSize: 12, color: Colors.grey[400]),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(context)?.ok ?? 'OK'),
          ),
        ],
      ),
    );
  }

  String _formatDate(String iso) {
    final d = DateTime.parse(iso).toLocal();
    return '${d.year}.${d.month.toString().padLeft(2, '0')}.${d.day.toString().padLeft(2, '0')}';
  }
}
