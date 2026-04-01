// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'ニャンニャンウォーター';

  @override
  String get login => 'ログイン';

  @override
  String get loginTitle => 'ニャンニャンウォーター';

  @override
  String get loginSubtitle => '水を飲む習慣をつけよう';

  @override
  String get loginWithGoogle => 'Googleでログイン';

  @override
  String get loginWithApple => 'Appleでログイン';

  @override
  String get devLogin => '開発用ログイン';

  @override
  String get termsAgree => 'ログインすると利用規約とプライバシーポリシーに同意したことになります';

  @override
  String get terms => '利用規約';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get onboardingStep1Title => 'はじめまして！🐱';

  @override
  String get onboardingStep1Subtitle => 'なんとお呼びしましょう？';

  @override
  String get onboardingNicknameHint => 'ニックネームを入力';

  @override
  String get onboardingStep2Title => '基本情報';

  @override
  String get onboardingStep2Subtitle => '水分目標を計算します';

  @override
  String get onboardingGender => '性別';

  @override
  String get onboardingMale => '男性';

  @override
  String get onboardingFemale => '女性';

  @override
  String get onboardingAgeGroup => '年齢層';

  @override
  String get onboardingAge20s => '20代';

  @override
  String get onboardingAge30s => '30代';

  @override
  String get onboardingAge40s => '40代';

  @override
  String get onboardingAge50plus => '50代以上';

  @override
  String get onboardingWeight => '体重';

  @override
  String get onboardingWeightUnit => 'kg';

  @override
  String get onboardingStep3Title => '生活パターン';

  @override
  String get onboardingStep3Subtitle => 'リマインダーをカスタマイズします';

  @override
  String get onboardingWakeTime => '起床時間';

  @override
  String get onboardingSleepTime => '就寝時間';

  @override
  String get onboardingStep4Title => 'もうすぐ完了！';

  @override
  String get onboardingStep4Subtitle => '活動量を教えてください';

  @override
  String get onboardingActivityLow => '少ない';

  @override
  String get onboardingActivityNormal => '普通';

  @override
  String get onboardingActivityHigh => '多い';

  @override
  String get onboardingActivityLowDesc => '主にデスクワーク';

  @override
  String get onboardingActivityNormalDesc => '軽い運動';

  @override
  String get onboardingActivityHighDesc => '活発な運動';

  @override
  String get onboardingYourGoal => '1日の水分目標';

  @override
  String get onboardingStart => '始める';

  @override
  String get next => '次へ';

  @override
  String get back => '戻る';

  @override
  String get home => 'ホーム';

  @override
  String get stats => '統計';

  @override
  String get settings => '設定';

  @override
  String get greetingMorning => 'おはようございます';

  @override
  String get greetingForenoon => '良い午前を';

  @override
  String get greetingLunch => 'お昼の時間です';

  @override
  String get greetingAfternoon => '良い午後を';

  @override
  String get greetingEvening => 'こんばんは';

  @override
  String get greetingNight => 'おやすみなさい';

  @override
  String get todayIntake => '今日の摂取量';

  @override
  String get goalAchieved => '目標達成！🎉';

  @override
  String remaining(Object amount) {
    return 'あと${amount}ml';
  }

  @override
  String get drinkWater => '水を飲む';

  @override
  String get customAmount => '直接入力';

  @override
  String get undo => '元に戻す';

  @override
  String get undoConfirm => '最後の記録を取り消しますか？';

  @override
  String get undoSuccess => '最後の記録を取り消しました';

  @override
  String get noRecordToUndo => '取り消す記録がありません';

  @override
  String get drinkTypeWater => '水';

  @override
  String get drinkTypeCoffee => 'コーヒー';

  @override
  String get drinkTypeTea => 'お茶';

  @override
  String get drinkTypeJuice => 'ジュース';

  @override
  String get drinkTypeOther => 'その他';

  @override
  String get todayRecord => '今日の記録';

  @override
  String get noRecordYet => 'まだ記録がありません';

  @override
  String get statsTitle => '統計';

  @override
  String get weeklySummary => '週間まとめ';

  @override
  String get dailyAverage => '1日平均';

  @override
  String get achievedDays => '達成日';

  @override
  String get totalIntake => '合計摂取量';

  @override
  String get calendar => 'カレンダー';

  @override
  String get streak => '連続達成';

  @override
  String streakDays(Object days) {
    return '$days日目';
  }

  @override
  String get settingsTitle => '設定';

  @override
  String get profile => 'プロフィール';

  @override
  String get editProfile => 'プロフィール編集';

  @override
  String get notification => '通知';

  @override
  String get notificationEnabled => '通知をオン';

  @override
  String get sound => 'サウンド';

  @override
  String get vibration => 'バイブレーション';

  @override
  String get theme => 'テーマ';

  @override
  String get themeSystem => 'システム';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get dataReset => 'データリセット';

  @override
  String get premium => 'プレミアム';

  @override
  String get premiumActive => '✅ 広告削除済み';

  @override
  String get removeAds => '広告削除';

  @override
  String get removeAdsDesc => 'すべての広告を永久に削除します。';

  @override
  String get removeAdsBanner => 'バナー広告削除';

  @override
  String get removeAdsInterstitial => '全面広告削除';

  @override
  String get removeAdsPermanent => '一度の購入で永久適用';

  @override
  String get purchase => '購入する';

  @override
  String get restore => '購入を復元';

  @override
  String get restoringPurchase => '購入履歴を復元中...';

  @override
  String get purchaseHistory => '購入履歴';

  @override
  String get noPurchaseHistory => '購入履歴がありません';

  @override
  String get premiumUser => 'プレミアム利用中 ✨';

  @override
  String get version => 'バージョン';

  @override
  String get deleteAccount => 'アカウント削除';

  @override
  String get deleteAccountConfirm => '本当にアカウントを削除しますか？\nすべてのデータが永久に削除されます。';

  @override
  String get logout => 'ログアウト';

  @override
  String get logoutConfirm => 'ログアウトしますか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => '確認';

  @override
  String get delete => '削除';

  @override
  String get save => '保存';

  @override
  String get ok => 'OK';

  @override
  String get customAmountTitle => '直接入力';

  @override
  String get customAmountHint => 'ml単位で入力';

  @override
  String get add => '追加';

  @override
  String get activityLevel => '活動量';

  @override
  String get wakeTime => '起床時間';

  @override
  String get sleepTime => '就寝時間';

  @override
  String get mealTimes => '食事時間';

  @override
  String get breakfast => '朝食';

  @override
  String get lunch => '昼食';

  @override
  String get dinner => '夕食';

  @override
  String get language => '言語';

  @override
  String get nickname => 'ニックネーム';

  @override
  String get notSet => '未設定';

  @override
  String get goal => '目標';

  @override
  String get achievements => '実績';

  @override
  String get catPerfect => '完璧！';

  @override
  String get catHappy => 'いいね！';

  @override
  String get catThirsty => 'のどが渇いた...';

  @override
  String get catCritical => '危険！';

  @override
  String get catNormal => '普通';

  @override
  String get connectionError => '接続できません';

  @override
  String get retry => '再試行';

  @override
  String get cups => '杯';

  @override
  String get onboardingNicknameRequired => '名前を教えてね！';

  @override
  String get saveFailed => '保存に失敗しました！';

  @override
  String get deleteAccountFailed => 'アカウント削除に失敗しました。';

  @override
  String get activityLowDesc2 => 'デスクワーク';

  @override
  String get activityNormalDesc2 => '通常活動';

  @override
  String get activityHighDesc2 => '運動、アウトドア';

  @override
  String activityFormula(Object n) {
    return '体重 × ${n}ml';
  }

  @override
  String yearMonth(Object month, Object year) {
    return '$year年$month月';
  }

  @override
  String consecutiveDays(Object n) {
    return '$n日連続達成';
  }

  @override
  String get keepGoing => 'すごい！続けよう！';

  @override
  String get startToday => '今日から始めよう！';

  @override
  String get deleteRecord => '記録削除';

  @override
  String get deleteRecordConfirm => 'この記録を削除しますか？';

  @override
  String get removeBannerAds => 'バナー広告削除';

  @override
  String get removeFullAds => '全画面広告削除';

  @override
  String get permanentPurchase => '一度の購入で永久適用';

  @override
  String get restorePurchase => '購入復元';

  @override
  String get resetConfirm => '全ての水の記録が削除されます。\nプロフィール情報は維持されます。';

  @override
  String get reset => 'リセット';

  @override
  String get removeAdsComplete => '広告削除完了';

  @override
  String get noPurchases => '購入履歴がありません';

  @override
  String get purchaseHint => '広告削除を購入するとここに表示されます';

  @override
  String get resetNotSupported => 'データリセットは準備中です。';

  @override
  String get dailyGoal => '1日の目標';

  @override
  String get catMessageNormal1 => 'お水の時間だよ~';

  @override
  String get catMessageNormal2 => '今日も元気に！';

  @override
  String get catMessageNormal3 => '一杯どう？';

  @override
  String get catMessageHappy1 => 'よくやってるね！👏';

  @override
  String get catMessageHappy2 => '水分補給の習慣最高！';

  @override
  String get catMessageHappy3 => 'この調子！続けよう~';

  @override
  String get catMessageThirsty1 => '喉が渇いたにゃ... 💧';

  @override
  String get catMessageThirsty2 => 'お水ちょうだい...！';

  @override
  String get catMessageThirsty3 => '乾燥してる...お水！';

  @override
  String get catMessageCritical1 => '危険！水を飲んで！🚨';

  @override
  String get catMessageCritical2 => 'お願い...お水...！';

  @override
  String get catMessagePerfect1 => '完璧！今日のヒーロー！🏆';

  @override
  String get catMessagePerfect2 => '目標達成！すごい！';

  @override
  String get weekMon => '月';

  @override
  String get weekTue => '火';

  @override
  String get weekWed => '水';

  @override
  String get weekThu => '木';

  @override
  String get weekFri => '金';

  @override
  String get weekSat => '土';

  @override
  String get weekSun => '日';

  @override
  String get average => '平均';

  @override
  String dateFormat(Object day, Object month, Object weekday) {
    return '$month月$day日 ($weekday)';
  }
}
