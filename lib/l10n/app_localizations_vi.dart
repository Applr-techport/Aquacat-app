// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'NyangNyang Water';

  @override
  String get login => 'Đăng nhập';

  @override
  String get loginTitle => 'AquaCat';

  @override
  String get loginSubtitle => 'Tạo thói quen uống nước';

  @override
  String get loginWithGoogle => 'Đăng nhập bằng Google';

  @override
  String get loginWithApple => 'Đăng nhập bằng Apple';

  @override
  String get devLogin => 'Đăng nhập thử';

  @override
  String get termsAgree =>
      'Đăng nhập là bạn đồng ý với Điều khoản và Chính sách bảo mật';

  @override
  String get terms => 'Điều khoản dịch vụ';

  @override
  String get privacyPolicy => 'Chính sách bảo mật';

  @override
  String get onboardingStep1Title => 'Xin chào! 🐱';

  @override
  String get onboardingStep1Subtitle => 'Tôi gọi bạn là gì?';

  @override
  String get onboardingNicknameHint => 'Nhập biệt danh';

  @override
  String get onboardingStep2Title => 'Thông tin cơ bản';

  @override
  String get onboardingStep2Subtitle =>
      'Chúng tôi sẽ tính mục tiêu nước cho bạn';

  @override
  String get onboardingGender => 'Giới tính';

  @override
  String get onboardingMale => 'Nam';

  @override
  String get onboardingFemale => 'Nữ';

  @override
  String get onboardingAgeGroup => 'Độ tuổi';

  @override
  String get onboardingAge20s => '20s';

  @override
  String get onboardingAge30s => '30s';

  @override
  String get onboardingAge40s => '40s';

  @override
  String get onboardingAge50plus => '50+';

  @override
  String get onboardingWeight => 'Cân nặng';

  @override
  String get onboardingWeightUnit => 'kg';

  @override
  String get onboardingStep3Title => 'Thói quen hàng ngày';

  @override
  String get onboardingStep3Subtitle => 'Tùy chỉnh thời gian nhắc nhở';

  @override
  String get onboardingWakeTime => 'Giờ thức dậy';

  @override
  String get onboardingSleepTime => 'Giờ đi ngủ';

  @override
  String get onboardingStep4Title => 'Sắp xong rồi!';

  @override
  String get onboardingStep4Subtitle => 'Cho chúng tôi biết mức độ hoạt động';

  @override
  String get onboardingActivityLow => 'Ít';

  @override
  String get onboardingActivityNormal => 'Bình thường';

  @override
  String get onboardingActivityHigh => 'Nhiều';

  @override
  String get onboardingActivityLowDesc => 'Chủ yếu ngồi';

  @override
  String get onboardingActivityNormalDesc => 'Tập nhẹ';

  @override
  String get onboardingActivityHighDesc => 'Tập nhiều';

  @override
  String get onboardingYourGoal => 'Mục tiêu nước hàng ngày';

  @override
  String get onboardingStart => 'Bắt đầu';

  @override
  String get next => 'Tiếp';

  @override
  String get back => 'Quay lại';

  @override
  String get home => 'Trang chủ';

  @override
  String get stats => 'Thống kê';

  @override
  String get settings => 'Cài đặt';

  @override
  String get greetingMorning => 'Chào buổi sáng';

  @override
  String get greetingForenoon => 'Buổi sáng tốt lành';

  @override
  String get greetingLunch => 'Giờ ăn trưa';

  @override
  String get greetingAfternoon => 'Chào buổi chiều';

  @override
  String get greetingEvening => 'Chào buổi tối';

  @override
  String get greetingNight => 'Chúc ngủ ngon';

  @override
  String get todayIntake => 'Lượng nước hôm nay';

  @override
  String get goalAchieved => 'Đạt mục tiêu! 🎉';

  @override
  String remaining(Object amount) {
    return 'Còn ${amount}ml';
  }

  @override
  String get drinkWater => 'Uống nước';

  @override
  String get customAmount => 'Tùy chỉnh';

  @override
  String get undo => 'Hoàn tác';

  @override
  String get undoConfirm => 'Hoàn tác bản ghi cuối?';

  @override
  String get undoSuccess => 'Đã hoàn tác';

  @override
  String get noRecordToUndo => 'Không có gì để hoàn tác';

  @override
  String get drinkTypeWater => 'Nước';

  @override
  String get drinkTypeCoffee => 'Cà phê';

  @override
  String get drinkTypeTea => 'Trà';

  @override
  String get drinkTypeJuice => 'Nước ép';

  @override
  String get drinkTypeOther => 'Khác';

  @override
  String get todayRecord => 'Ghi chép hôm nay';

  @override
  String get noRecordYet => 'Chưa có ghi chép';

  @override
  String get statsTitle => 'Thống kê';

  @override
  String get weeklySummary => 'Tóm tắt tuần';

  @override
  String get dailyAverage => 'Trung bình/ngày';

  @override
  String get achievedDays => 'Ngày đạt';

  @override
  String get totalIntake => 'Tổng lượng';

  @override
  String get calendar => 'Lịch';

  @override
  String get streak => 'Chuỗi ngày';

  @override
  String streakDays(Object days) {
    return 'Ngày $days';
  }

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get profile => 'Hồ sơ';

  @override
  String get editProfile => 'Sửa hồ sơ';

  @override
  String get notification => 'Thông báo';

  @override
  String get notificationEnabled => 'Bật thông báo';

  @override
  String get sound => 'Âm thanh';

  @override
  String get vibration => 'Rung';

  @override
  String get theme => 'Giao diện';

  @override
  String get themeSystem => 'Hệ thống';

  @override
  String get themeLight => 'Sáng';

  @override
  String get themeDark => 'Tối';

  @override
  String get dataReset => 'Đặt lại dữ liệu';

  @override
  String get premium => 'Premium';

  @override
  String get premiumActive => '✅ Đã xóa quảng cáo';

  @override
  String get removeAds => 'Xóa quảng cáo';

  @override
  String get removeAdsDesc => 'Xóa tất cả quảng cáo vĩnh viễn.';

  @override
  String get removeAdsBanner => 'Xóa banner';

  @override
  String get removeAdsInterstitial => 'Xóa quảng cáo toàn màn hình';

  @override
  String get removeAdsPermanent => 'Mua một lần, dùng mãi';

  @override
  String get purchase => 'Mua';

  @override
  String get restore => 'Khôi phục mua hàng';

  @override
  String get restoringPurchase => 'Đang khôi phục...';

  @override
  String get purchaseHistory => 'Lịch sử mua';

  @override
  String get noPurchaseHistory => 'Chưa có lịch sử mua';

  @override
  String get premiumUser => 'Đang dùng Premium ✨';

  @override
  String get version => 'Phiên bản';

  @override
  String get deleteAccount => 'Xóa tài khoản';

  @override
  String get deleteAccountConfirm =>
      'Bạn chắc chắn muốn xóa tài khoản?\nTất cả dữ liệu sẽ bị xóa vĩnh viễn.';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get logoutConfirm => 'Bạn muốn đăng xuất?';

  @override
  String get cancel => 'Hủy';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get delete => 'Xóa';

  @override
  String get save => 'Lưu';

  @override
  String get ok => 'OK';

  @override
  String get customAmountTitle => 'Tùy chỉnh';

  @override
  String get customAmountHint => 'Nhập số ml';

  @override
  String get add => 'Thêm';

  @override
  String get activityLevel => 'Mức hoạt động';

  @override
  String get wakeTime => 'Giờ thức dậy';

  @override
  String get sleepTime => 'Giờ đi ngủ';

  @override
  String get mealTimes => 'Giờ ăn';

  @override
  String get breakfast => 'Sáng';

  @override
  String get lunch => 'Trưa';

  @override
  String get dinner => 'Tối';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get nickname => 'Biệt danh';

  @override
  String get notSet => 'Chưa đặt';

  @override
  String get goal => 'Mục tiêu';

  @override
  String get achievements => 'Thành tích';

  @override
  String get catPerfect => 'Hoàn hảo!';

  @override
  String get catHappy => 'Vui!';

  @override
  String get catThirsty => 'Khát...';

  @override
  String get catCritical => 'Nguy hiểm!';

  @override
  String get catNormal => 'Bình thường';

  @override
  String get connectionError => 'Không thể kết nối';

  @override
  String get retry => 'Thử lại';

  @override
  String get cups => 'ly';

  @override
  String get onboardingNicknameRequired => 'Cho mình biết tên bạn nhé!';

  @override
  String get saveFailed => 'Lưu thất bại! Hãy thử lại.';

  @override
  String get deleteAccountFailed => 'Xóa tài khoản thất bại.';

  @override
  String get activityLowDesc2 => 'Văn phòng';

  @override
  String get activityNormalDesc2 => 'Hoạt động bình thường';

  @override
  String get activityHighDesc2 => 'Thể thao, ngoài trời';

  @override
  String activityFormula(Object n) {
    return 'Cân nặng × ${n}ml';
  }

  @override
  String yearMonth(Object month, Object year) {
    return 'Tháng $month/$year';
  }

  @override
  String consecutiveDays(Object n) {
    return '$n ngày liên tiếp';
  }

  @override
  String get keepGoing => 'Tuyệt vời! Tiếp tục nhé!';

  @override
  String get startToday => 'Bắt đầu từ hôm nay!';

  @override
  String get deleteRecord => 'Xóa bản ghi';

  @override
  String get deleteRecordConfirm => 'Xóa bản ghi này?';

  @override
  String get removeBannerAds => 'Xóa quảng cáo banner';

  @override
  String get removeFullAds => 'Xóa quảng cáo toàn màn hình';

  @override
  String get permanentPurchase => 'Mua một lần, dùng mãi';

  @override
  String get restorePurchase => 'Khôi phục mua hàng';

  @override
  String get resetConfirm =>
      'Tất cả bản ghi uống nước sẽ bị xóa.\nThông tin cá nhân sẽ được giữ lại.';

  @override
  String get reset => 'Đặt lại';

  @override
  String get removeAdsComplete => 'Đã xóa quảng cáo';

  @override
  String get noPurchases => 'Không có lịch sử mua';

  @override
  String get purchaseHint => 'Mua xóa quảng cáo sẽ hiển thị ở đây';

  @override
  String get resetNotSupported => 'Đặt lại dữ liệu sắp có.';

  @override
  String get dailyGoal => 'Mục tiêu hàng ngày';

  @override
  String get catMessageNormal1 => 'Giờ uống nước nè~';

  @override
  String get catMessageNormal2 => 'Hôm nay cũng khỏe nhé!';

  @override
  String get catMessageNormal3 => 'Một ly nước nhé?';

  @override
  String get catMessageHappy1 => 'Giỏi lắm! 👏';

  @override
  String get catMessageHappy2 => 'Thói quen tuyệt vời!';

  @override
  String get catMessageHappy3 => 'Tiếp tục nhé!';

  @override
  String get catMessageThirsty1 => 'Khát quá... 💧';

  @override
  String get catMessageThirsty2 => 'Cho nước đi...!';

  @override
  String get catMessageThirsty3 => 'Khô quá... nước!';

  @override
  String get catMessageCritical1 => 'Nguy hiểm! Uống ngay! 🚨';

  @override
  String get catMessageCritical2 => 'Xin hãy... nước...!';

  @override
  String get catMessagePerfect1 => 'Hoàn hảo! Anh hùng! 🏆';

  @override
  String get catMessagePerfect2 => 'Đạt mục tiêu! Tuyệt vời!';

  @override
  String get weekMon => 'T2';

  @override
  String get weekTue => 'T3';

  @override
  String get weekWed => 'T4';

  @override
  String get weekThu => 'T5';

  @override
  String get weekFri => 'T6';

  @override
  String get weekSat => 'T7';

  @override
  String get weekSun => 'CN';

  @override
  String get average => 'TB';

  @override
  String dateFormat(Object day, Object month, Object weekday) {
    return '$weekday $day/$month';
  }
}
