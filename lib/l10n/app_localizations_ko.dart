// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => '냥냥워터';

  @override
  String get login => '로그인';

  @override
  String get loginTitle => '냥냥워터';

  @override
  String get loginSubtitle => '물 마시기 습관을 만들어요';

  @override
  String get loginWithGoogle => 'Google로 로그인';

  @override
  String get loginWithApple => 'Apple로 로그인';

  @override
  String get devLogin => '개발용 로그인';

  @override
  String get termsAgree => '로그인 시 이용약관 및 개인정보처리방침에 동의합니다';

  @override
  String get terms => '이용약관';

  @override
  String get privacyPolicy => '개인정보처리방침';

  @override
  String get onboardingStep1Title => '반가워요! 🐱';

  @override
  String get onboardingStep1Subtitle => '뭐라고 불러드릴까요?';

  @override
  String get onboardingNicknameHint => '별명을 입력하세요';

  @override
  String get onboardingStep2Title => '기본 정보';

  @override
  String get onboardingStep2Subtitle => '맞춤 수분 목표를 계산할게요';

  @override
  String get onboardingGender => '성별';

  @override
  String get onboardingMale => '남성';

  @override
  String get onboardingFemale => '여성';

  @override
  String get onboardingAgeGroup => '연령대';

  @override
  String get onboardingAge20s => '20대';

  @override
  String get onboardingAge30s => '30대';

  @override
  String get onboardingAge40s => '40대';

  @override
  String get onboardingAge50plus => '50대 이상';

  @override
  String get onboardingWeight => '체중';

  @override
  String get onboardingWeightUnit => 'kg';

  @override
  String get onboardingStep3Title => '생활 패턴';

  @override
  String get onboardingStep3Subtitle => '알림 시간을 맞춤 설정할게요';

  @override
  String get onboardingWakeTime => '기상 시간';

  @override
  String get onboardingSleepTime => '취침 시간';

  @override
  String get onboardingStep4Title => '거의 다 됐어요!';

  @override
  String get onboardingStep4Subtitle => '활동량을 알려주세요';

  @override
  String get onboardingActivityLow => '적음';

  @override
  String get onboardingActivityNormal => '보통';

  @override
  String get onboardingActivityHigh => '많음';

  @override
  String get onboardingActivityLowDesc => '주로 앉아서 생활';

  @override
  String get onboardingActivityNormalDesc => '가벼운 운동';

  @override
  String get onboardingActivityHighDesc => '활발한 운동';

  @override
  String get onboardingYourGoal => '나의 하루 수분 목표';

  @override
  String get onboardingStart => '시작하기';

  @override
  String get next => '다음';

  @override
  String get back => '뒤로';

  @override
  String get home => '홈';

  @override
  String get stats => '통계';

  @override
  String get settings => '설정';

  @override
  String get greetingMorning => '좋은 아침이에요';

  @override
  String get greetingForenoon => '좋은 오전이에요';

  @override
  String get greetingLunch => '점심시간이에요';

  @override
  String get greetingAfternoon => '좋은 오후에요';

  @override
  String get greetingEvening => '좋은 저녁이에요';

  @override
  String get greetingNight => '편안한 밤이에요';

  @override
  String get todayIntake => '오늘 섭취량';

  @override
  String get goalAchieved => '목표 달성! 🎉';

  @override
  String remaining(Object amount) {
    return '${amount}ml 남았어요';
  }

  @override
  String get drinkWater => '물 마시기';

  @override
  String get customAmount => '직접 입력';

  @override
  String get undo => '되돌리기';

  @override
  String get undoConfirm => '마지막 기록을 취소할까요?';

  @override
  String get undoSuccess => '마지막 기록이 취소되었어요';

  @override
  String get noRecordToUndo => '취소할 기록이 없어요';

  @override
  String get drinkTypeWater => '물';

  @override
  String get drinkTypeCoffee => '커피';

  @override
  String get drinkTypeTea => '차';

  @override
  String get drinkTypeJuice => '음료';

  @override
  String get drinkTypeOther => '기타';

  @override
  String get todayRecord => '오늘 기록';

  @override
  String get noRecordYet => '아직 기록이 없어요';

  @override
  String get statsTitle => '통계';

  @override
  String get weeklySummary => '주간 요약';

  @override
  String get dailyAverage => '일 평균';

  @override
  String get achievedDays => '달성일';

  @override
  String get totalIntake => '총 섭취량';

  @override
  String get calendar => '캘린더';

  @override
  String get streak => '연속 달성';

  @override
  String streakDays(Object days) {
    return '$days일째';
  }

  @override
  String get settingsTitle => '설정';

  @override
  String get profile => '프로필';

  @override
  String get editProfile => '프로필 수정';

  @override
  String get notification => '알림';

  @override
  String get notificationEnabled => '알림 켜기';

  @override
  String get sound => '소리';

  @override
  String get vibration => '진동';

  @override
  String get theme => '테마';

  @override
  String get themeSystem => '시스템';

  @override
  String get themeLight => '라이트';

  @override
  String get themeDark => '다크';

  @override
  String get dataReset => '데이터 초기화';

  @override
  String get premium => '프리미엄';

  @override
  String get premiumActive => '✅ 광고 제거 완료';

  @override
  String get removeAds => '광고 제거';

  @override
  String get removeAdsDesc => '모든 광고를 영구 제거합니다.';

  @override
  String get removeAdsBanner => '배너 광고 제거';

  @override
  String get removeAdsInterstitial => '전면 광고 제거';

  @override
  String get removeAdsPermanent => '한 번 구매로 영구 적용';

  @override
  String get purchase => '구매하기';

  @override
  String get restore => '구매 복원';

  @override
  String get restoringPurchase => '구매 내역을 복원하는 중...';

  @override
  String get purchaseHistory => '구매 내역';

  @override
  String get noPurchaseHistory => '구매 내역이 없습니다';

  @override
  String get premiumUser => '프리미엄 이용 중 ✨';

  @override
  String get version => '버전';

  @override
  String get deleteAccount => '계정 삭제';

  @override
  String get deleteAccountConfirm => '정말로 계정을 삭제하시겠습니까?\n모든 데이터가 영구적으로 삭제됩니다.';

  @override
  String get logout => '로그아웃';

  @override
  String get logoutConfirm => '로그아웃 하시겠습니까?';

  @override
  String get cancel => '취소';

  @override
  String get confirm => '확인';

  @override
  String get delete => '삭제';

  @override
  String get save => '저장';

  @override
  String get ok => '확인';

  @override
  String get customAmountTitle => '직접 입력';

  @override
  String get customAmountHint => 'ml 단위로 입력';

  @override
  String get add => '추가';

  @override
  String get activityLevel => '활동량';

  @override
  String get wakeTime => '기상 시간';

  @override
  String get sleepTime => '취침 시간';

  @override
  String get mealTimes => '식사 시간';

  @override
  String get breakfast => '아침';

  @override
  String get lunch => '점심';

  @override
  String get dinner => '저녁';

  @override
  String get language => '언어';

  @override
  String get nickname => '호칭';

  @override
  String get notSet => '미설정';

  @override
  String get goal => '목표';

  @override
  String get achievements => '업적';

  @override
  String get catPerfect => '완벽해!';

  @override
  String get catHappy => '좋아!';

  @override
  String get catThirsty => '목말라...';

  @override
  String get catCritical => '위험!';

  @override
  String get catNormal => '보통';

  @override
  String get connectionError => '연결할 수 없어요';

  @override
  String get retry => '다시 시도';

  @override
  String get cups => '잔';

  @override
  String get onboardingNicknameRequired => '냥이가 부를 이름을 알려줘!';

  @override
  String get saveFailed => '저장 실패! 다시 시도해주세요.';

  @override
  String get deleteAccountFailed => '계정 삭제에 실패했습니다.';

  @override
  String get activityLowDesc2 => '사무직, 재택';

  @override
  String get activityNormalDesc2 => '일반 활동';

  @override
  String get activityHighDesc2 => '운동, 야외';

  @override
  String activityFormula(Object n) {
    return '체중 × ${n}ml';
  }

  @override
  String yearMonth(Object month, Object year) {
    return '$year년 $month월';
  }

  @override
  String consecutiveDays(Object n) {
    return '$n일 연속 달성';
  }

  @override
  String get keepGoing => '대단해! 계속 이어가자!';

  @override
  String get startToday => '오늘부터 시작해봐!';

  @override
  String get deleteRecord => '기록 삭제';

  @override
  String get deleteRecordConfirm => '이 기록을 삭제할까요?';

  @override
  String get removeBannerAds => '배너 광고 제거';

  @override
  String get removeFullAds => '전면 광고 제거';

  @override
  String get permanentPurchase => '한 번 구매로 영구 적용';

  @override
  String get restorePurchase => '구매 복원';

  @override
  String get resetConfirm => '모든 물 마시기 기록이 삭제됩니다.\n프로필 정보는 유지됩니다.';

  @override
  String get reset => '초기화';

  @override
  String get removeAdsComplete => '광고 제거 완료';

  @override
  String get noPurchases => '구매 내역이 없습니다';

  @override
  String get purchaseHint => '광고 제거를 구매하면 여기에 표시됩니다';

  @override
  String get resetNotSupported => '데이터 초기화는 준비 중입니다.';

  @override
  String get dailyGoal => '일일 목표';

  @override
  String get catMessageNormal1 => '물 마실 시간이야~';

  @override
  String get catMessageNormal2 => '오늘도 건강하게!';

  @override
  String get catMessageNormal3 => '물 한 잔 어때?';

  @override
  String get catMessageHappy1 => '잘하고 있어! 👏';

  @override
  String get catMessageHappy2 => '물 마시기 습관 최고!';

  @override
  String get catMessageHappy3 => '이 조자세! 계속 가자~';

  @override
  String get catMessageThirsty1 => '목이 마르다냥... 💧';

  @override
  String get catMessageThirsty2 => '물 좀 줘...!';

  @override
  String get catMessageThirsty3 => '건조해... 물 부탁!';

  @override
  String get catMessageCritical1 => '위험해! 물 마셔! 🚨';

  @override
  String get catMessageCritical2 => '제발 물 좀...!';

  @override
  String get catMessagePerfect1 => '완벽해! 오늘의 영웅! 🏆';

  @override
  String get catMessagePerfect2 => '목표 달성! 대단해!';

  @override
  String get weekMon => '월';

  @override
  String get weekTue => '화';

  @override
  String get weekWed => '수';

  @override
  String get weekThu => '목';

  @override
  String get weekFri => '금';

  @override
  String get weekSat => '토';

  @override
  String get weekSun => '일';

  @override
  String get average => '평균';

  @override
  String dateFormat(Object day, Object month, Object weekday) {
    return '$month월 $day일 $weekday요일';
  }
}
