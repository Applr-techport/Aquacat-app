import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isKo = Localizations.localeOf(context).languageCode == 'ko';
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.privacyPolicy ?? 'Privacy Policy', style: TextStyle(color: AppTheme.textPrimaryFor(context))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: isKo ? _koSections() : _enSections(),
        ),
      ),
    );
  }

  List<Widget> _koSections() => [
    _section('1. 개인정보의 수집 및 이용 목적',
      '냥냥워터(이하 "앱")는 다음의 목적을 위해 개인정보를 수집 및 이용합니다.\n'
      '• 회원 식별 및 서비스 제공\n'
      '• 맞춤형 수분 섭취 목표 계산\n'
      '• 서비스 개선 및 통계 분석'),
    _section('2. 수집하는 개인정보 항목',
      '• 필수: 이메일, 로그인 제공자(Google/Apple)\n'
      '• 선택: 닉네임, 성별, 연령대, 체중, 기상/취침 시간, 활동량'),
    _section('3. 개인정보의 보유 및 이용 기간',
      '회원 탈퇴 시 즉시 파기합니다. 단, 관계 법령에 따라 보존이 필요한 경우 해당 기간 동안 보관합니다.\n'
      '• 서비스 이용 기록: 1년'),
    _section('4. 개인정보의 제3자 제공',
      '앱은 이용자의 개인정보를 제3자에게 제공하지 않습니다. 단, 법령에 의한 경우는 예외로 합니다.'),
    _section('5. 개인정보의 파기',
      '회원 탈퇴 또는 수집 목적 달성 시 지체 없이 파기합니다.\n'
      '• 전자적 파일: 복구 불가능한 방법으로 삭제\n'
      '• 종이 문서: 분쇄 또는 소각'),
    _section('6. 이용자의 권리',
      '이용자는 언제든지 자신의 개인정보를 조회, 수정, 삭제할 수 있으며, 계정 삭제를 통해 탈퇴할 수 있습니다.'),
    _section('7. 개인정보 보호책임자',
      '• 서비스명: 냥냥워터\n• 이메일: support@aquacat.app'),
    _section('8. 시행일', '본 개인정보처리방침은 2026년 2월 16일부터 시행됩니다.'),
    const SizedBox(height: 40),
  ];

  List<Widget> _enSections() => [
    _section('1. Purpose of Collection',
      'AquaCat ("App") collects personal information for the following purposes:\n'
      '• User identification and service delivery\n'
      '• Personalized hydration goal calculation\n'
      '• Service improvement and statistical analysis'),
    _section('2. Information Collected',
      '• Required: Email, login provider (Google/Apple)\n'
      '• Optional: Nickname, gender, age group, weight, wake/sleep time, activity level'),
    _section('3. Retention Period',
      'Personal information is deleted immediately upon account deletion, except where retention is required by law.\n'
      '• Service usage records: 1 year'),
    _section('4. Third-Party Disclosure',
      'The App does not share personal information with third parties, except as required by law.'),
    _section('5. Data Destruction',
      'Data is destroyed without delay upon account deletion or when the purpose of collection is fulfilled.\n'
      '• Electronic files: Deleted using irrecoverable methods\n'
      '• Paper documents: Shredded or incinerated'),
    _section('6. User Rights',
      'Users may view, modify, or delete their personal information at any time, and may withdraw by deleting their account.'),
    _section('7. Contact',
      '• Service: AquaCat\n• Email: support@aquacat.app'),
    _section('8. Effective Date', 'This privacy policy is effective from February 16, 2026.'),
    const SizedBox(height: 40),
  ];

  Widget _section(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 13, height: 1.8, color: Color(0xFF4B5563))),
        ],
      ),
    );
  }
}
