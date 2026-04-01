// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => '喵喵水';

  @override
  String get login => '登录';

  @override
  String get loginTitle => '喵喵水';

  @override
  String get loginSubtitle => '养成喝水好习惯';

  @override
  String get loginWithGoogle => '使用Google登录';

  @override
  String get loginWithApple => '使用Apple登录';

  @override
  String get devLogin => '开发者登录';

  @override
  String get termsAgree => '登录即表示您同意我们的服务条款和隐私政策';

  @override
  String get terms => '服务条款';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get onboardingStep1Title => '你好！🐱';

  @override
  String get onboardingStep1Subtitle => '怎么称呼你？';

  @override
  String get onboardingNicknameHint => '请输入昵称';

  @override
  String get onboardingStep2Title => '基本信息';

  @override
  String get onboardingStep2Subtitle => '我们来计算你的饮水目标';

  @override
  String get onboardingGender => '性别';

  @override
  String get onboardingMale => '男';

  @override
  String get onboardingFemale => '女';

  @override
  String get onboardingAgeGroup => '年龄段';

  @override
  String get onboardingAge20s => '20多岁';

  @override
  String get onboardingAge30s => '30多岁';

  @override
  String get onboardingAge40s => '40多岁';

  @override
  String get onboardingAge50plus => '50岁以上';

  @override
  String get onboardingWeight => '体重';

  @override
  String get onboardingWeightUnit => 'kg';

  @override
  String get onboardingStep3Title => '生活习惯';

  @override
  String get onboardingStep3Subtitle => '定制你的提醒时间';

  @override
  String get onboardingWakeTime => '起床时间';

  @override
  String get onboardingSleepTime => '就寝时间';

  @override
  String get onboardingStep4Title => '快完成了！';

  @override
  String get onboardingStep4Subtitle => '告诉我们你的活动量';

  @override
  String get onboardingActivityLow => '少';

  @override
  String get onboardingActivityNormal => '一般';

  @override
  String get onboardingActivityHigh => '多';

  @override
  String get onboardingActivityLowDesc => '久坐为主';

  @override
  String get onboardingActivityNormalDesc => '轻度运动';

  @override
  String get onboardingActivityHighDesc => '大量运动';

  @override
  String get onboardingYourGoal => '每日饮水目标';

  @override
  String get onboardingStart => '开始';

  @override
  String get next => '下一步';

  @override
  String get back => '返回';

  @override
  String get home => '首页';

  @override
  String get stats => '统计';

  @override
  String get settings => '设置';

  @override
  String get greetingMorning => '早上好';

  @override
  String get greetingForenoon => '上午好';

  @override
  String get greetingLunch => '午饭时间';

  @override
  String get greetingAfternoon => '下午好';

  @override
  String get greetingEvening => '晚上好';

  @override
  String get greetingNight => '晚安';

  @override
  String get todayIntake => '今日摄入量';

  @override
  String get goalAchieved => '目标达成！🎉';

  @override
  String remaining(Object amount) {
    return '还剩${amount}ml';
  }

  @override
  String get drinkWater => '喝水';

  @override
  String get customAmount => '自定义';

  @override
  String get undo => '撤销';

  @override
  String get undoConfirm => '撤销最后一条记录？';

  @override
  String get undoSuccess => '已撤销最后一条记录';

  @override
  String get noRecordToUndo => '没有可撤销的记录';

  @override
  String get drinkTypeWater => '水';

  @override
  String get drinkTypeCoffee => '咖啡';

  @override
  String get drinkTypeTea => '茶';

  @override
  String get drinkTypeJuice => '饮料';

  @override
  String get drinkTypeOther => '其他';

  @override
  String get todayRecord => '今日记录';

  @override
  String get noRecordYet => '暂无记录';

  @override
  String get statsTitle => '统计';

  @override
  String get weeklySummary => '周总结';

  @override
  String get dailyAverage => '日均';

  @override
  String get achievedDays => '达标天数';

  @override
  String get totalIntake => '总摄入量';

  @override
  String get calendar => '日历';

  @override
  String get streak => '连续达标';

  @override
  String streakDays(Object days) {
    return '第$days天';
  }

  @override
  String get settingsTitle => '设置';

  @override
  String get profile => '个人资料';

  @override
  String get editProfile => '编辑资料';

  @override
  String get notification => '通知';

  @override
  String get notificationEnabled => '开启通知';

  @override
  String get sound => '声音';

  @override
  String get vibration => '振动';

  @override
  String get theme => '主题';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get dataReset => '重置数据';

  @override
  String get premium => '高级版';

  @override
  String get premiumActive => '✅ 已移除广告';

  @override
  String get removeAds => '移除广告';

  @override
  String get removeAdsDesc => '永久去除所有广告。';

  @override
  String get removeAdsBanner => '移除横幅广告';

  @override
  String get removeAdsInterstitial => '移除插屏广告';

  @override
  String get removeAdsPermanent => '一次购买永久有效';

  @override
  String get purchase => '购买';

  @override
  String get restore => '恢复购买';

  @override
  String get restoringPurchase => '正在恢复购买...';

  @override
  String get purchaseHistory => '购买记录';

  @override
  String get noPurchaseHistory => '暂无购买记录';

  @override
  String get premiumUser => '高级版使用中 ✨';

  @override
  String get version => '版本';

  @override
  String get deleteAccount => '删除账户';

  @override
  String get deleteAccountConfirm => '确定要删除账户吗？\n所有数据将被永久删除。';

  @override
  String get logout => '退出登录';

  @override
  String get logoutConfirm => '确定要退出登录吗？';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get delete => '删除';

  @override
  String get save => '保存';

  @override
  String get ok => '确定';

  @override
  String get customAmountTitle => '自定义';

  @override
  String get customAmountHint => '输入ml数';

  @override
  String get add => '添加';

  @override
  String get activityLevel => '活动量';

  @override
  String get wakeTime => '起床时间';

  @override
  String get sleepTime => '就寝时间';

  @override
  String get mealTimes => '用餐时间';

  @override
  String get breakfast => '早餐';

  @override
  String get lunch => '午餐';

  @override
  String get dinner => '晚餐';

  @override
  String get language => '语言';

  @override
  String get nickname => '昵称';

  @override
  String get notSet => '未设置';

  @override
  String get goal => '目标';

  @override
  String get achievements => '成就';

  @override
  String get catPerfect => '完美！';

  @override
  String get catHappy => '开心！';

  @override
  String get catThirsty => '口渴了...';

  @override
  String get catCritical => '危险！';

  @override
  String get catNormal => '普通';

  @override
  String get connectionError => '无法连接';

  @override
  String get retry => '重试';

  @override
  String get cups => '杯';

  @override
  String get onboardingNicknameRequired => '告诉我你的名字吧！';

  @override
  String get saveFailed => '保存失败！请重试。';

  @override
  String get deleteAccountFailed => '删除账号失败。';

  @override
  String get activityLowDesc2 => '办公室、居家';

  @override
  String get activityNormalDesc2 => '正常活动';

  @override
  String get activityHighDesc2 => '运动、户外';

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
    return '连续$n天达标';
  }

  @override
  String get keepGoing => '太棒了！继续加油！';

  @override
  String get startToday => '从今天开始吧！';

  @override
  String get deleteRecord => '删除记录';

  @override
  String get deleteRecordConfirm => '删除这条记录吗？';

  @override
  String get removeBannerAds => '去除横幅广告';

  @override
  String get removeFullAds => '去除全屏广告';

  @override
  String get permanentPurchase => '一次购买永久生效';

  @override
  String get restorePurchase => '恢复购买';

  @override
  String get resetConfirm => '所有喝水记录将被删除。\n个人信息将保留。';

  @override
  String get reset => '重置';

  @override
  String get removeAdsComplete => '已去除广告';

  @override
  String get noPurchases => '无购买记录';

  @override
  String get purchaseHint => '购买去广告后会显示在这里';

  @override
  String get resetNotSupported => '数据重置即将推出。';

  @override
  String get dailyGoal => '每日目标';

  @override
  String get catMessageNormal1 => '该喝水啦~';

  @override
  String get catMessageNormal2 => '今天也要健康哦！';

  @override
  String get catMessageNormal3 => '来一杯怎么样？';

  @override
  String get catMessageHappy1 => '做得好！👏';

  @override
  String get catMessageHappy2 => '喝水习惯棒棒的！';

  @override
  String get catMessageHappy3 => '继续保持！';

  @override
  String get catMessageThirsty1 => '好渴喵... 💧';

  @override
  String get catMessageThirsty2 => '给我水...！';

  @override
  String get catMessageThirsty3 => '好干...要水！';

  @override
  String get catMessageCritical1 => '危险！快喝水！🚨';

  @override
  String get catMessageCritical2 => '拜托...水...！';

  @override
  String get catMessagePerfect1 => '完美！今天的英雄！🏆';

  @override
  String get catMessagePerfect2 => '目标达成！太厉害了！';

  @override
  String get weekMon => '一';

  @override
  String get weekTue => '二';

  @override
  String get weekWed => '三';

  @override
  String get weekThu => '四';

  @override
  String get weekFri => '五';

  @override
  String get weekSat => '六';

  @override
  String get weekSun => '日';

  @override
  String get average => '平均';

  @override
  String dateFormat(Object day, Object month, Object weekday) {
    return '$month月$day日 周$weekday';
  }
}
