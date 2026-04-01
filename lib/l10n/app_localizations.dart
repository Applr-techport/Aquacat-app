import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('ja'),
    Locale('ko'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'AquaCat'**
  String get appName;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'AquaCat'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Build your water drinking habit'**
  String get loginSubtitle;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get loginWithGoogle;

  /// No description provided for @loginWithApple.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get loginWithApple;

  /// No description provided for @devLogin.
  ///
  /// In en, this message translates to:
  /// **'Dev Login'**
  String get devLogin;

  /// No description provided for @termsAgree.
  ///
  /// In en, this message translates to:
  /// **'By logging in, you agree to our Terms of Service and Privacy Policy'**
  String get termsAgree;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @onboardingStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Welcome! 🐱'**
  String get onboardingStep1Title;

  /// No description provided for @onboardingStep1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'What should I call you?'**
  String get onboardingStep1Subtitle;

  /// No description provided for @onboardingNicknameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your nickname'**
  String get onboardingNicknameHint;

  /// No description provided for @onboardingStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Basic Info'**
  String get onboardingStep2Title;

  /// No description provided for @onboardingStep2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll calculate your hydration goal'**
  String get onboardingStep2Subtitle;

  /// No description provided for @onboardingGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get onboardingGender;

  /// No description provided for @onboardingMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get onboardingMale;

  /// No description provided for @onboardingFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get onboardingFemale;

  /// No description provided for @onboardingAgeGroup.
  ///
  /// In en, this message translates to:
  /// **'Age group'**
  String get onboardingAgeGroup;

  /// No description provided for @onboardingAge20s.
  ///
  /// In en, this message translates to:
  /// **'20s'**
  String get onboardingAge20s;

  /// No description provided for @onboardingAge30s.
  ///
  /// In en, this message translates to:
  /// **'30s'**
  String get onboardingAge30s;

  /// No description provided for @onboardingAge40s.
  ///
  /// In en, this message translates to:
  /// **'40s'**
  String get onboardingAge40s;

  /// No description provided for @onboardingAge50plus.
  ///
  /// In en, this message translates to:
  /// **'50+'**
  String get onboardingAge50plus;

  /// No description provided for @onboardingWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get onboardingWeight;

  /// No description provided for @onboardingWeightUnit.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get onboardingWeightUnit;

  /// No description provided for @onboardingStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Daily Routine'**
  String get onboardingStep3Title;

  /// No description provided for @onboardingStep3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll customize your reminders'**
  String get onboardingStep3Subtitle;

  /// No description provided for @onboardingWakeTime.
  ///
  /// In en, this message translates to:
  /// **'Wake up time'**
  String get onboardingWakeTime;

  /// No description provided for @onboardingSleepTime.
  ///
  /// In en, this message translates to:
  /// **'Bed time'**
  String get onboardingSleepTime;

  /// No description provided for @onboardingStep4Title.
  ///
  /// In en, this message translates to:
  /// **'Almost done!'**
  String get onboardingStep4Title;

  /// No description provided for @onboardingStep4Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us your activity level'**
  String get onboardingStep4Subtitle;

  /// No description provided for @onboardingActivityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get onboardingActivityLow;

  /// No description provided for @onboardingActivityNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get onboardingActivityNormal;

  /// No description provided for @onboardingActivityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get onboardingActivityHigh;

  /// No description provided for @onboardingActivityLowDesc.
  ///
  /// In en, this message translates to:
  /// **'Mostly sedentary'**
  String get onboardingActivityLowDesc;

  /// No description provided for @onboardingActivityNormalDesc.
  ///
  /// In en, this message translates to:
  /// **'Light exercise'**
  String get onboardingActivityNormalDesc;

  /// No description provided for @onboardingActivityHighDesc.
  ///
  /// In en, this message translates to:
  /// **'Active exercise'**
  String get onboardingActivityHighDesc;

  /// No description provided for @onboardingYourGoal.
  ///
  /// In en, this message translates to:
  /// **'Your daily hydration goal'**
  String get onboardingYourGoal;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingStart;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @stats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get stats;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// No description provided for @greetingForenoon.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingForenoon;

  /// No description provided for @greetingLunch.
  ///
  /// In en, this message translates to:
  /// **'It\'s lunch time'**
  String get greetingLunch;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// No description provided for @greetingNight.
  ///
  /// In en, this message translates to:
  /// **'Good night'**
  String get greetingNight;

  /// No description provided for @todayIntake.
  ///
  /// In en, this message translates to:
  /// **'Today\'s intake'**
  String get todayIntake;

  /// No description provided for @goalAchieved.
  ///
  /// In en, this message translates to:
  /// **'Goal achieved! 🎉'**
  String get goalAchieved;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'{amount}ml remaining'**
  String remaining(Object amount);

  /// No description provided for @drinkWater.
  ///
  /// In en, this message translates to:
  /// **'Drink Water'**
  String get drinkWater;

  /// No description provided for @customAmount.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get customAmount;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @undoConfirm.
  ///
  /// In en, this message translates to:
  /// **'Undo last record?'**
  String get undoConfirm;

  /// No description provided for @undoSuccess.
  ///
  /// In en, this message translates to:
  /// **'Last record undone'**
  String get undoSuccess;

  /// No description provided for @noRecordToUndo.
  ///
  /// In en, this message translates to:
  /// **'No record to undo'**
  String get noRecordToUndo;

  /// No description provided for @drinkTypeWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get drinkTypeWater;

  /// No description provided for @drinkTypeCoffee.
  ///
  /// In en, this message translates to:
  /// **'Coffee'**
  String get drinkTypeCoffee;

  /// No description provided for @drinkTypeTea.
  ///
  /// In en, this message translates to:
  /// **'Tea'**
  String get drinkTypeTea;

  /// No description provided for @drinkTypeJuice.
  ///
  /// In en, this message translates to:
  /// **'Juice'**
  String get drinkTypeJuice;

  /// No description provided for @drinkTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get drinkTypeOther;

  /// No description provided for @todayRecord.
  ///
  /// In en, this message translates to:
  /// **'Today\'s records'**
  String get todayRecord;

  /// No description provided for @noRecordYet.
  ///
  /// In en, this message translates to:
  /// **'No records yet'**
  String get noRecordYet;

  /// No description provided for @statsTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statsTitle;

  /// No description provided for @weeklySummary.
  ///
  /// In en, this message translates to:
  /// **'Weekly Summary'**
  String get weeklySummary;

  /// No description provided for @dailyAverage.
  ///
  /// In en, this message translates to:
  /// **'Daily avg'**
  String get dailyAverage;

  /// No description provided for @achievedDays.
  ///
  /// In en, this message translates to:
  /// **'Days achieved'**
  String get achievedDays;

  /// No description provided for @totalIntake.
  ///
  /// In en, this message translates to:
  /// **'Total intake'**
  String get totalIntake;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'Day {days}'**
  String streakDays(Object days);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notification;

  /// No description provided for @notificationEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications'**
  String get notificationEnabled;

  /// No description provided for @sound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// No description provided for @vibration.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get vibration;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @dataReset.
  ///
  /// In en, this message translates to:
  /// **'Reset Data'**
  String get dataReset;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @premiumActive.
  ///
  /// In en, this message translates to:
  /// **'✅ Ads removed'**
  String get premiumActive;

  /// No description provided for @removeAds.
  ///
  /// In en, this message translates to:
  /// **'Remove Ads'**
  String get removeAds;

  /// No description provided for @removeAdsDesc.
  ///
  /// In en, this message translates to:
  /// **'Remove all ads permanently.'**
  String get removeAdsDesc;

  /// No description provided for @removeAdsBanner.
  ///
  /// In en, this message translates to:
  /// **'Remove banner ads'**
  String get removeAdsBanner;

  /// No description provided for @removeAdsInterstitial.
  ///
  /// In en, this message translates to:
  /// **'Remove interstitial ads'**
  String get removeAdsInterstitial;

  /// No description provided for @removeAdsPermanent.
  ///
  /// In en, this message translates to:
  /// **'One-time purchase, forever'**
  String get removeAdsPermanent;

  /// No description provided for @purchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchase;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchase'**
  String get restore;

  /// No description provided for @restoringPurchase.
  ///
  /// In en, this message translates to:
  /// **'Restoring purchases...'**
  String get restoringPurchase;

  /// No description provided for @purchaseHistory.
  ///
  /// In en, this message translates to:
  /// **'Purchase History'**
  String get purchaseHistory;

  /// No description provided for @noPurchaseHistory.
  ///
  /// In en, this message translates to:
  /// **'No purchase history'**
  String get noPurchaseHistory;

  /// No description provided for @premiumUser.
  ///
  /// In en, this message translates to:
  /// **'Premium active ✨'**
  String get premiumUser;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account?\nAll data will be permanently deleted.'**
  String get deleteAccountConfirm;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @customAmountTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom Amount'**
  String get customAmountTitle;

  /// No description provided for @customAmountHint.
  ///
  /// In en, this message translates to:
  /// **'Enter amount in ml'**
  String get customAmountHint;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @activityLevel.
  ///
  /// In en, this message translates to:
  /// **'Activity Level'**
  String get activityLevel;

  /// No description provided for @wakeTime.
  ///
  /// In en, this message translates to:
  /// **'Wake up time'**
  String get wakeTime;

  /// No description provided for @sleepTime.
  ///
  /// In en, this message translates to:
  /// **'Bed time'**
  String get sleepTime;

  /// No description provided for @mealTimes.
  ///
  /// In en, this message translates to:
  /// **'Meal times'**
  String get mealTimes;

  /// No description provided for @breakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get breakfast;

  /// No description provided for @lunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get lunch;

  /// No description provided for @dinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get dinner;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @nickname.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get nickname;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @goal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goal;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @catPerfect.
  ///
  /// In en, this message translates to:
  /// **'Perfect!'**
  String get catPerfect;

  /// No description provided for @catHappy.
  ///
  /// In en, this message translates to:
  /// **'Happy!'**
  String get catHappy;

  /// No description provided for @catThirsty.
  ///
  /// In en, this message translates to:
  /// **'Thirsty...'**
  String get catThirsty;

  /// No description provided for @catCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical!'**
  String get catCritical;

  /// No description provided for @catNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get catNormal;

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'Can\'t connect'**
  String get connectionError;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @cups.
  ///
  /// In en, this message translates to:
  /// **'cups'**
  String get cups;

  /// No description provided for @onboardingNicknameRequired.
  ///
  /// In en, this message translates to:
  /// **'Tell me your name!'**
  String get onboardingNicknameRequired;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed! Please try again.'**
  String get saveFailed;

  /// No description provided for @deleteAccountFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete account.'**
  String get deleteAccountFailed;

  /// No description provided for @activityLowDesc2.
  ///
  /// In en, this message translates to:
  /// **'Desk job, remote'**
  String get activityLowDesc2;

  /// No description provided for @activityNormalDesc2.
  ///
  /// In en, this message translates to:
  /// **'Normal activity'**
  String get activityNormalDesc2;

  /// No description provided for @activityHighDesc2.
  ///
  /// In en, this message translates to:
  /// **'Exercise, outdoor'**
  String get activityHighDesc2;

  /// No description provided for @activityFormula.
  ///
  /// In en, this message translates to:
  /// **'Weight × {n}ml'**
  String activityFormula(Object n);

  /// No description provided for @yearMonth.
  ///
  /// In en, this message translates to:
  /// **'{month}/{year}'**
  String yearMonth(Object month, Object year);

  /// No description provided for @consecutiveDays.
  ///
  /// In en, this message translates to:
  /// **'{n} day streak'**
  String consecutiveDays(Object n);

  /// No description provided for @keepGoing.
  ///
  /// In en, this message translates to:
  /// **'Amazing! Keep going!'**
  String get keepGoing;

  /// No description provided for @startToday.
  ///
  /// In en, this message translates to:
  /// **'Start today!'**
  String get startToday;

  /// No description provided for @deleteRecord.
  ///
  /// In en, this message translates to:
  /// **'Delete record'**
  String get deleteRecord;

  /// No description provided for @deleteRecordConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this record?'**
  String get deleteRecordConfirm;

  /// No description provided for @removeBannerAds.
  ///
  /// In en, this message translates to:
  /// **'Remove banner ads'**
  String get removeBannerAds;

  /// No description provided for @removeFullAds.
  ///
  /// In en, this message translates to:
  /// **'Remove full-screen ads'**
  String get removeFullAds;

  /// No description provided for @permanentPurchase.
  ///
  /// In en, this message translates to:
  /// **'One-time purchase, forever'**
  String get permanentPurchase;

  /// No description provided for @restorePurchase.
  ///
  /// In en, this message translates to:
  /// **'Restore purchase'**
  String get restorePurchase;

  /// No description provided for @resetConfirm.
  ///
  /// In en, this message translates to:
  /// **'All water records will be deleted.\nProfile info will be kept.'**
  String get resetConfirm;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @removeAdsComplete.
  ///
  /// In en, this message translates to:
  /// **'Ads removed'**
  String get removeAdsComplete;

  /// No description provided for @noPurchases.
  ///
  /// In en, this message translates to:
  /// **'No purchases'**
  String get noPurchases;

  /// No description provided for @purchaseHint.
  ///
  /// In en, this message translates to:
  /// **'Purchase ad removal to see it here'**
  String get purchaseHint;

  /// No description provided for @resetNotSupported.
  ///
  /// In en, this message translates to:
  /// **'Data reset coming soon.'**
  String get resetNotSupported;

  /// No description provided for @dailyGoal.
  ///
  /// In en, this message translates to:
  /// **'Daily goal'**
  String get dailyGoal;

  /// No description provided for @catMessageNormal1.
  ///
  /// In en, this message translates to:
  /// **'Time for water~'**
  String get catMessageNormal1;

  /// No description provided for @catMessageNormal2.
  ///
  /// In en, this message translates to:
  /// **'Stay healthy today!'**
  String get catMessageNormal2;

  /// No description provided for @catMessageNormal3.
  ///
  /// In en, this message translates to:
  /// **'How about a glass?'**
  String get catMessageNormal3;

  /// No description provided for @catMessageHappy1.
  ///
  /// In en, this message translates to:
  /// **'Great job! 👏'**
  String get catMessageHappy1;

  /// No description provided for @catMessageHappy2.
  ///
  /// In en, this message translates to:
  /// **'Hydration habit rocks!'**
  String get catMessageHappy2;

  /// No description provided for @catMessageHappy3.
  ///
  /// In en, this message translates to:
  /// **'Keep it up!'**
  String get catMessageHappy3;

  /// No description provided for @catMessageThirsty1.
  ///
  /// In en, this message translates to:
  /// **'So thirsty... 💧'**
  String get catMessageThirsty1;

  /// No description provided for @catMessageThirsty2.
  ///
  /// In en, this message translates to:
  /// **'Water please...!'**
  String get catMessageThirsty2;

  /// No description provided for @catMessageThirsty3.
  ///
  /// In en, this message translates to:
  /// **'Feeling dry... water!'**
  String get catMessageThirsty3;

  /// No description provided for @catMessageCritical1.
  ///
  /// In en, this message translates to:
  /// **'Danger! Drink now! 🚨'**
  String get catMessageCritical1;

  /// No description provided for @catMessageCritical2.
  ///
  /// In en, this message translates to:
  /// **'Please... water...!'**
  String get catMessageCritical2;

  /// No description provided for @catMessagePerfect1.
  ///
  /// In en, this message translates to:
  /// **'Perfect! Today\'s hero! 🏆'**
  String get catMessagePerfect1;

  /// No description provided for @catMessagePerfect2.
  ///
  /// In en, this message translates to:
  /// **'Goal achieved! Amazing!'**
  String get catMessagePerfect2;

  /// No description provided for @weekMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get weekMon;

  /// No description provided for @weekTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get weekTue;

  /// No description provided for @weekWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get weekWed;

  /// No description provided for @weekThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get weekThu;

  /// No description provided for @weekFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get weekFri;

  /// No description provided for @weekSat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get weekSat;

  /// No description provided for @weekSun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get weekSun;

  /// No description provided for @average.
  ///
  /// In en, this message translates to:
  /// **'Avg'**
  String get average;

  /// No description provided for @dateFormat.
  ///
  /// In en, this message translates to:
  /// **'{weekday}, {month}/{day}'**
  String dateFormat(Object day, Object month, Object weekday);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'en',
    'es',
    'ja',
    'ko',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
