import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isKo = Localizations.localeOf(context).languageCode == 'ko';
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.terms ?? 'Terms of Service', style: TextStyle(color: AppTheme.textPrimaryFor(context))),
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
    _section('제1조 (목적)', '본 약관은 아쿠아캣(이하 "앱")가 제공하는 수분 섭취 관리 서비스의 이용과 관련하여 앱과 이용자 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.'),
    _section('제2조 (정의)', '• "서비스"란 앱이 제공하는 수분 섭취 기록, 목표 관리, 건강 팁 등 일체의 서비스를 말합니다.\n• "이용자"란 본 약관에 따라 서비스를 이용하는 자를 말합니다.'),
    _section('제3조 (약관의 효력)', '본 약관은 서비스를 이용하고자 하는 모든 이용자에게 적용됩니다. 약관에 동의하지 않는 경우 서비스를 이용할 수 없습니다.'),
    _section('제4조 (서비스 내용)', '앱은 다음의 서비스를 제공합니다.\n• 개인별 맞춤 수분 섭취 목표 계산\n• 물 마시기 기록 및 통계\n• 건강 팁 제공\n• 리마인더 알림'),
    _section('제5조 (이용자의 의무)', '이용자는 다음 행위를 해서는 안 됩니다.\n• 타인의 정보를 부정하게 사용하는 행위\n• 서비스의 정상적 운영을 방해하는 행위\n• 관계 법령을 위반하는 행위'),
    _section('제6조 (면책)', '• 앱이 제공하는 수분 섭취 정보는 참고용이며, 의학적 조언을 대체하지 않습니다.\n• 개인의 건강 상태에 따라 적정 수분량은 다를 수 있으므로, 필요 시 전문의와 상담하시기 바랍니다.\n• 천재지변, 시스템 장애 등 불가항력에 의한 서비스 중단에 대해 책임지지 않습니다.'),
    _section('제7조 (서비스 변경 및 중단)', '앱은 운영상, 기술상의 필요에 따라 서비스를 변경하거나 중단할 수 있으며, 사전에 공지합니다.'),
    _section('제8조 (계정 삭제)', '이용자는 앱 내 설정에서 언제든지 계정을 삭제할 수 있으며, 삭제 시 모든 데이터가 즉시 파기됩니다.'),
    _section('제9조 (시행일)', '본 약관은 2026년 2월 16일부터 시행됩니다.'),
    const SizedBox(height: 40),
  ];

  List<Widget> _enSections() => [
    _section('Article 1 (Purpose)', 'These Terms govern the rights, obligations, and responsibilities between AquaCat ("App") and its users regarding the hydration management service.'),
    _section('Article 2 (Definitions)', '• "Service" refers to all services provided by the App, including water intake tracking, goal management, and health tips.\n• "User" refers to anyone who uses the Service under these Terms.'),
    _section('Article 3 (Applicability)', 'These Terms apply to all users. If you do not agree, you may not use the Service.'),
    _section('Article 4 (Service Description)', 'The App provides:\n• Personalized hydration goal calculation\n• Water intake tracking and statistics\n• Health tips\n• Reminder notifications'),
    _section('Article 5 (User Obligations)', 'Users shall not:\n• Use others\' information fraudulently\n• Interfere with normal service operation\n• Violate applicable laws'),
    _section('Article 6 (Disclaimer)', '• Hydration information is for reference only and does not replace medical advice.\n• Optimal water intake varies by individual health; consult a physician if needed.\n• The App is not liable for service interruptions due to force majeure.'),
    _section('Article 7 (Service Changes)', 'The App may modify or discontinue the Service for operational or technical reasons, with prior notice.'),
    _section('Article 8 (Account Deletion)', 'Users may delete their account at any time via Settings. All data is immediately destroyed upon deletion.'),
    _section('Article 9 (Effective Date)', 'These Terms are effective from February 16, 2026.'),
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
