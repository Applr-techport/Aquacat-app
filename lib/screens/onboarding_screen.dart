import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../services/api_service.dart';
import 'main_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _saving = false;

  // Form data
  final _nicknameController = TextEditingController(text: '');
  String _gender = 'male';
  String _ageGroup = '30s';
  double _weight = 70;
  String _wakeTime = '08:00';
  String _sleepTime = '24:00';
  String _activityLevel = 'normal';

  void _next() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _complete();
    }
  }

  Future<void> _complete() async {
    if (_nicknameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)?.onboardingNicknameRequired ?? '냥이가 부를 이름을 알려줘!')),
      );
      _pageController.jumpToPage(0);
      return;
    }

    setState(() => _saving = true);
    try {
      await ApiService().completeOnboarding({
        'displayName': _nicknameController.text.trim(),
        'gender': _gender,
        'ageGroup': _ageGroup,
        'weight': _weight,
        'wakeTime': _wakeTime,
        'sleepTime': _sleepTime,
        'activityLevel': _activityLevel,
      });
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)?.saveFailed ?? '저장 실패! 다시 시도해주세요.')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header: back + progress + step
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                      onPressed: () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                    )
                  else
                    const SizedBox(width: 48),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (i) {
                        return Expanded(
                          child: Container(
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: i <= _currentPage
                                  ? AppTheme.primary
                                  : AppTheme.primaryLight.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    width: 48,
                    child: Text(
                      '${_currentPage + 1}/4',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: AppTheme.textSecondaryFor(context), fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            // Pages
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildNicknamePage(),
                  _buildBodyPage(),
                  _buildTimePage(),
                  _buildActivityPage(),
                ],
              ),
            ),
            // Button
            Padding(
              padding: const EdgeInsets.all(32),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _saving ? null : _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _saving
                      ? const SizedBox(
                          width: 20, height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text(
                          _currentPage < 3 ? (AppLocalizations.of(context)?.next ?? '다음') : (AppLocalizations.of(context)?.onboardingStart ?? '시작하기!'),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNicknamePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/svg/happy.svg', width: 120, height: 120),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)?.onboardingStep1Title ?? '반가워! 🐱',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.textPrimaryFor(context)),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)?.onboardingStep1Subtitle ?? '뭐라고 불러드릴까요?',
            style: TextStyle(fontSize: 15, color: AppTheme.textSecondaryFor(context)),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _nicknameController,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)?.onboardingNicknameHint ?? '별명을 입력하세요',
              hintStyle: TextStyle(color: Colors.grey[300]),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)?.onboardingStep2Title ?? '기본 정보',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.textPrimaryFor(context)),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)?.onboardingStep2Subtitle ?? '맞춤 수분 목표를 계산할게요',
            style: TextStyle(fontSize: 15, color: AppTheme.textSecondaryFor(context)),
          ),
          const SizedBox(height: 32),
          // Gender
          Row(
            children: [
              const SizedBox(width: 4),
              Text(AppLocalizations.of(context)?.onboardingGender ?? '성별', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              const Spacer(),
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(value: 'male', label: Text(AppLocalizations.of(context)?.onboardingMale ?? '남성')),
                  ButtonSegment(value: 'female', label: Text(AppLocalizations.of(context)?.onboardingFemale ?? '여성')),
                ],
                selected: {_gender},
                onSelectionChanged: (v) => setState(() => _gender = v.first),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Age group
          Row(
            children: [
              Text(AppLocalizations.of(context)?.onboardingAgeGroup ?? '연령대', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              const Spacer(),
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(value: '20s', label: Text(AppLocalizations.of(context)?.onboardingAge20s ?? '20대')),
                  ButtonSegment(value: '30s', label: Text(AppLocalizations.of(context)?.onboardingAge30s ?? '30대')),
                  ButtonSegment(value: '40s', label: Text(AppLocalizations.of(context)?.onboardingAge40s ?? '40대')),
                  ButtonSegment(value: '50+', label: Text(AppLocalizations.of(context)?.onboardingAge50plus ?? '50+')),
                ],
                selected: {_ageGroup},
                onSelectionChanged: (v) => setState(() => _ageGroup = v.first),
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  textStyle: WidgetStatePropertyAll(const TextStyle(fontSize: 13)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Weight
          Row(
            children: [
              Text(AppLocalizations.of(context)?.onboardingWeight ?? '체중', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              const Spacer(),
              Text('${_weight.toInt()}kg',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.primary)),
            ],
          ),
          Slider(
            value: _weight,
            min: 30,
            max: 150,
            divisions: 120,
            label: '${_weight.toInt()}kg',
            onChanged: (v) => setState(() => _weight = v),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)?.onboardingStep3Title ?? '생활 패턴',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.textPrimaryFor(context)),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)?.onboardingStep3Subtitle ?? '알림 시간을 맞춤 설정할게요',
            style: TextStyle(fontSize: 15, color: AppTheme.textSecondaryFor(context)),
          ),
          const SizedBox(height: 40),
          _buildTimeSelector(AppLocalizations.of(context)?.onboardingWakeTime ?? '기상 시간', _wakeTime, Icons.wb_sunny_outlined, (v) {
            setState(() => _wakeTime = v);
          }),
          const SizedBox(height: 24),
          _buildTimeSelector(AppLocalizations.of(context)?.onboardingSleepTime ?? '취침 시간', _sleepTime, Icons.nights_stay_outlined, (v) {
            setState(() => _sleepTime = v);
          }),
        ],
      ),
    );
  }

  Widget _buildTimeSelector(String label, String value, IconData icon, ValueChanged<String> onChanged) {
    final isWake = icon == Icons.wb_sunny_outlined;
    final hours = isWake
        ? ['05:00', '05:30', '06:00', '06:30', '07:00', '07:30', '08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00']
        : ['21:00', '21:30', '22:00', '22:30', '23:00', '23:30', '24:00', '00:30', '01:00', '01:30', '02:00'];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primary),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const Spacer(),
          DropdownButton<String>(
            value: hours.contains(value) ? value : hours.first,
            items: hours.map((h) => DropdownMenuItem(value: h, child: Text(h))).toList(),
            onChanged: (v) => onChanged(v!),
            underline: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityPage() {
    final goalMl = _calcGoal();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/svg/normal.svg', width: 100, height: 100),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)?.onboardingStep4Title ?? '거의 다 됐어요!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.textPrimaryFor(context)),
          ),
          const SizedBox(height: 32),
          ...['low', 'normal', 'high'].map((level) {
            final ll = AppLocalizations.of(context);
            final labels = {
              'low': '${ll?.onboardingActivityLow ?? "적음"} (${ll?.onboardingActivityLowDesc ?? "사무직, 재택"})',
              'normal': '${ll?.onboardingActivityNormal ?? "보통"} (${ll?.onboardingActivityNormalDesc ?? "일반 활동"})',
              'high': '${ll?.onboardingActivityHigh ?? "많음"} (${ll?.onboardingActivityHighDesc ?? "운동, 야외"})',
            };
            final multipliers = {'low': 30, 'normal': 33, 'high': 40};
            return GestureDetector(
              onTap: () => setState(() => _activityLevel = level),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _activityLevel == level ? AppTheme.primary.withValues(alpha: 0.1) : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _activityLevel == level ? AppTheme.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Text(labels[level]!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    if (_activityLevel == level)
                      const Icon(Icons.check_circle, color: AppTheme.primary, size: 22),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryLight.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('💧 일일 목표: ', style: TextStyle(fontSize: 15)),
                Text(
                  '${goalMl}ml',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _calcGoal() {
    const ageBase = {'20s': 37, '30s': 33, '40s': 30, '50+': 27};
    const activityAdj = {'low': -3, 'normal': 0, 'high': 5};
    final base = ageBase[_ageGroup] ?? 33;
    final adj = activityAdj[_activityLevel] ?? 0;
    final raw = (_weight * (base + adj)).round();
    return ((raw + 50) ~/ 100) * 100;
  }
}
