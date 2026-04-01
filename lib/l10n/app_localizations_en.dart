// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'NyangNyang Water';

  @override
  String get login => 'Login';

  @override
  String get loginTitle => 'AquaCat';

  @override
  String get loginSubtitle => 'Build your water drinking habit';

  @override
  String get loginWithGoogle => 'Sign in with Google';

  @override
  String get loginWithApple => 'Sign in with Apple';

  @override
  String get devLogin => 'Dev Login';

  @override
  String get termsAgree =>
      'By logging in, you agree to our Terms of Service and Privacy Policy';

  @override
  String get terms => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get onboardingStep1Title => 'Welcome! 🐱';

  @override
  String get onboardingStep1Subtitle => 'What should I call you?';

  @override
  String get onboardingNicknameHint => 'Enter your nickname';

  @override
  String get onboardingStep2Title => 'Basic Info';

  @override
  String get onboardingStep2Subtitle => 'We\'ll calculate your hydration goal';

  @override
  String get onboardingGender => 'Gender';

  @override
  String get onboardingMale => 'Male';

  @override
  String get onboardingFemale => 'Female';

  @override
  String get onboardingAgeGroup => 'Age group';

  @override
  String get onboardingAge20s => '20s';

  @override
  String get onboardingAge30s => '30s';

  @override
  String get onboardingAge40s => '40s';

  @override
  String get onboardingAge50plus => '50+';

  @override
  String get onboardingWeight => 'Weight';

  @override
  String get onboardingWeightUnit => 'kg';

  @override
  String get onboardingStep3Title => 'Daily Routine';

  @override
  String get onboardingStep3Subtitle => 'We\'ll customize your reminders';

  @override
  String get onboardingWakeTime => 'Wake up time';

  @override
  String get onboardingSleepTime => 'Bed time';

  @override
  String get onboardingStep4Title => 'Almost done!';

  @override
  String get onboardingStep4Subtitle => 'Tell us your activity level';

  @override
  String get onboardingActivityLow => 'Low';

  @override
  String get onboardingActivityNormal => 'Normal';

  @override
  String get onboardingActivityHigh => 'High';

  @override
  String get onboardingActivityLowDesc => 'Mostly sedentary';

  @override
  String get onboardingActivityNormalDesc => 'Light exercise';

  @override
  String get onboardingActivityHighDesc => 'Active exercise';

  @override
  String get onboardingYourGoal => 'Your daily hydration goal';

  @override
  String get onboardingStart => 'Get Started';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get home => 'Home';

  @override
  String get stats => 'Stats';

  @override
  String get settings => 'Settings';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingForenoon => 'Good morning';

  @override
  String get greetingLunch => 'It\'s lunch time';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get greetingNight => 'Good night';

  @override
  String get todayIntake => 'Today\'s intake';

  @override
  String get goalAchieved => 'Goal achieved! 🎉';

  @override
  String remaining(Object amount) {
    return '${amount}ml remaining';
  }

  @override
  String get drinkWater => 'Drink Water';

  @override
  String get customAmount => 'Custom';

  @override
  String get undo => 'Undo';

  @override
  String get undoConfirm => 'Undo last record?';

  @override
  String get undoSuccess => 'Last record undone';

  @override
  String get noRecordToUndo => 'No record to undo';

  @override
  String get drinkTypeWater => 'Water';

  @override
  String get drinkTypeCoffee => 'Coffee';

  @override
  String get drinkTypeTea => 'Tea';

  @override
  String get drinkTypeJuice => 'Juice';

  @override
  String get drinkTypeOther => 'Other';

  @override
  String get todayRecord => 'Today\'s records';

  @override
  String get noRecordYet => 'No records yet';

  @override
  String get statsTitle => 'Statistics';

  @override
  String get weeklySummary => 'Weekly Summary';

  @override
  String get dailyAverage => 'Daily avg';

  @override
  String get achievedDays => 'Days achieved';

  @override
  String get totalIntake => 'Total intake';

  @override
  String get calendar => 'Calendar';

  @override
  String get streak => 'Streak';

  @override
  String streakDays(Object days) {
    return 'Day $days';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get profile => 'Profile';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get notification => 'Notifications';

  @override
  String get notificationEnabled => 'Enable notifications';

  @override
  String get sound => 'Sound';

  @override
  String get vibration => 'Vibration';

  @override
  String get theme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get dataReset => 'Reset Data';

  @override
  String get premium => 'Premium';

  @override
  String get premiumActive => '✅ Ads removed';

  @override
  String get removeAds => 'Remove Ads';

  @override
  String get removeAdsDesc => 'Remove all ads permanently.';

  @override
  String get removeAdsBanner => 'Remove banner ads';

  @override
  String get removeAdsInterstitial => 'Remove interstitial ads';

  @override
  String get removeAdsPermanent => 'One-time purchase, forever';

  @override
  String get purchase => 'Purchase';

  @override
  String get restore => 'Restore Purchase';

  @override
  String get restoringPurchase => 'Restoring purchases...';

  @override
  String get purchaseHistory => 'Purchase History';

  @override
  String get noPurchaseHistory => 'No purchase history';

  @override
  String get premiumUser => 'Premium active ✨';

  @override
  String get version => 'Version';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountConfirm =>
      'Are you sure you want to delete your account?\nAll data will be permanently deleted.';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirm => 'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get delete => 'Delete';

  @override
  String get save => 'Save';

  @override
  String get ok => 'OK';

  @override
  String get customAmountTitle => 'Custom Amount';

  @override
  String get customAmountHint => 'Enter amount in ml';

  @override
  String get add => 'Add';

  @override
  String get activityLevel => 'Activity Level';

  @override
  String get wakeTime => 'Wake up time';

  @override
  String get sleepTime => 'Bed time';

  @override
  String get mealTimes => 'Meal times';

  @override
  String get breakfast => 'Breakfast';

  @override
  String get lunch => 'Lunch';

  @override
  String get dinner => 'Dinner';

  @override
  String get language => 'Language';

  @override
  String get nickname => 'Nickname';

  @override
  String get notSet => 'Not set';

  @override
  String get goal => 'Goal';

  @override
  String get achievements => 'Achievements';

  @override
  String get catPerfect => 'Perfect!';

  @override
  String get catHappy => 'Happy!';

  @override
  String get catThirsty => 'Thirsty...';

  @override
  String get catCritical => 'Critical!';

  @override
  String get catNormal => 'Normal';

  @override
  String get connectionError => 'Can\'t connect';

  @override
  String get retry => 'Retry';

  @override
  String get cups => 'cups';

  @override
  String get onboardingNicknameRequired => 'Tell me your name!';

  @override
  String get saveFailed => 'Save failed! Please try again.';

  @override
  String get deleteAccountFailed => 'Failed to delete account.';

  @override
  String get activityLowDesc2 => 'Desk job, remote';

  @override
  String get activityNormalDesc2 => 'Normal activity';

  @override
  String get activityHighDesc2 => 'Exercise, outdoor';

  @override
  String activityFormula(Object n) {
    return 'Weight × ${n}ml';
  }

  @override
  String yearMonth(Object month, Object year) {
    return '$month/$year';
  }

  @override
  String consecutiveDays(Object n) {
    return '$n day streak';
  }

  @override
  String get keepGoing => 'Amazing! Keep going!';

  @override
  String get startToday => 'Start today!';

  @override
  String get deleteRecord => 'Delete record';

  @override
  String get deleteRecordConfirm => 'Delete this record?';

  @override
  String get removeBannerAds => 'Remove banner ads';

  @override
  String get removeFullAds => 'Remove full-screen ads';

  @override
  String get permanentPurchase => 'One-time purchase, forever';

  @override
  String get restorePurchase => 'Restore purchase';

  @override
  String get resetConfirm =>
      'All water records will be deleted.\nProfile info will be kept.';

  @override
  String get reset => 'Reset';

  @override
  String get removeAdsComplete => 'Ads removed';

  @override
  String get noPurchases => 'No purchases';

  @override
  String get purchaseHint => 'Purchase ad removal to see it here';

  @override
  String get resetNotSupported => 'Data reset coming soon.';

  @override
  String get dailyGoal => 'Daily goal';

  @override
  String get catMessageNormal1 => 'Time for water~';

  @override
  String get catMessageNormal2 => 'Stay healthy today!';

  @override
  String get catMessageNormal3 => 'How about a glass?';

  @override
  String get catMessageHappy1 => 'Great job! 👏';

  @override
  String get catMessageHappy2 => 'Hydration habit rocks!';

  @override
  String get catMessageHappy3 => 'Keep it up!';

  @override
  String get catMessageThirsty1 => 'So thirsty... 💧';

  @override
  String get catMessageThirsty2 => 'Water please...!';

  @override
  String get catMessageThirsty3 => 'Feeling dry... water!';

  @override
  String get catMessageCritical1 => 'Danger! Drink now! 🚨';

  @override
  String get catMessageCritical2 => 'Please... water...!';

  @override
  String get catMessagePerfect1 => 'Perfect! Today\'s hero! 🏆';

  @override
  String get catMessagePerfect2 => 'Goal achieved! Amazing!';

  @override
  String get weekMon => 'Mon';

  @override
  String get weekTue => 'Tue';

  @override
  String get weekWed => 'Wed';

  @override
  String get weekThu => 'Thu';

  @override
  String get weekFri => 'Fri';

  @override
  String get weekSat => 'Sat';

  @override
  String get weekSun => 'Sun';

  @override
  String get average => 'Avg';

  @override
  String dateFormat(Object day, Object month, Object weekday) {
    return '$weekday, $month/$day';
  }
}
