// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'AquaCat';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get loginTitle => 'AquaCat';

  @override
  String get loginSubtitle => 'Crea tu hábito de beber agua';

  @override
  String get loginWithGoogle => 'Iniciar con Google';

  @override
  String get loginWithApple => 'Iniciar con Apple';

  @override
  String get devLogin => 'Login de desarrollo';

  @override
  String get termsAgree =>
      'Al iniciar sesión, aceptas nuestros Términos y Política de Privacidad';

  @override
  String get terms => 'Términos de servicio';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get onboardingStep1Title => '¡Hola! 🐱';

  @override
  String get onboardingStep1Subtitle => '¿Cómo te llamo?';

  @override
  String get onboardingNicknameHint => 'Ingresa tu apodo';

  @override
  String get onboardingStep2Title => 'Información básica';

  @override
  String get onboardingStep2Subtitle => 'Calcularemos tu meta de hidratación';

  @override
  String get onboardingGender => 'Género';

  @override
  String get onboardingMale => 'Masculino';

  @override
  String get onboardingFemale => 'Femenino';

  @override
  String get onboardingAgeGroup => 'Edad';

  @override
  String get onboardingAge20s => '20s';

  @override
  String get onboardingAge30s => '30s';

  @override
  String get onboardingAge40s => '40s';

  @override
  String get onboardingAge50plus => '50+';

  @override
  String get onboardingWeight => 'Peso';

  @override
  String get onboardingWeightUnit => 'kg';

  @override
  String get onboardingStep3Title => 'Rutina diaria';

  @override
  String get onboardingStep3Subtitle => 'Personalizaremos tus recordatorios';

  @override
  String get onboardingWakeTime => 'Hora de despertar';

  @override
  String get onboardingSleepTime => 'Hora de dormir';

  @override
  String get onboardingStep4Title => '¡Casi listo!';

  @override
  String get onboardingStep4Subtitle => 'Dinos tu nivel de actividad';

  @override
  String get onboardingActivityLow => 'Bajo';

  @override
  String get onboardingActivityNormal => 'Normal';

  @override
  String get onboardingActivityHigh => 'Alto';

  @override
  String get onboardingActivityLowDesc => 'Mayormente sedentario';

  @override
  String get onboardingActivityNormalDesc => 'Ejercicio ligero';

  @override
  String get onboardingActivityHighDesc => 'Ejercicio activo';

  @override
  String get onboardingYourGoal => 'Tu meta diaria de hidratación';

  @override
  String get onboardingStart => 'Comenzar';

  @override
  String get next => 'Siguiente';

  @override
  String get back => 'Atrás';

  @override
  String get home => 'Inicio';

  @override
  String get stats => 'Estadísticas';

  @override
  String get settings => 'Ajustes';

  @override
  String get greetingMorning => 'Buenos días';

  @override
  String get greetingForenoon => 'Buena mañana';

  @override
  String get greetingLunch => 'Hora de almorzar';

  @override
  String get greetingAfternoon => 'Buenas tardes';

  @override
  String get greetingEvening => 'Buenas noches';

  @override
  String get greetingNight => 'Buenas noches';

  @override
  String get todayIntake => 'Ingesta de hoy';

  @override
  String get goalAchieved => '¡Meta lograda! 🎉';

  @override
  String remaining(Object amount) {
    return 'Faltan ${amount}ml';
  }

  @override
  String get drinkWater => 'Beber agua';

  @override
  String get customAmount => 'Personalizar';

  @override
  String get undo => 'Deshacer';

  @override
  String get undoConfirm => '¿Deshacer último registro?';

  @override
  String get undoSuccess => 'Último registro deshecho';

  @override
  String get noRecordToUndo => 'No hay registro para deshacer';

  @override
  String get drinkTypeWater => 'Agua';

  @override
  String get drinkTypeCoffee => 'Café';

  @override
  String get drinkTypeTea => 'Té';

  @override
  String get drinkTypeJuice => 'Jugo';

  @override
  String get drinkTypeOther => 'Otro';

  @override
  String get todayRecord => 'Registros de hoy';

  @override
  String get noRecordYet => 'Sin registros aún';

  @override
  String get statsTitle => 'Estadísticas';

  @override
  String get weeklySummary => 'Resumen semanal';

  @override
  String get dailyAverage => 'Promedio diario';

  @override
  String get achievedDays => 'Días logrados';

  @override
  String get totalIntake => 'Ingesta total';

  @override
  String get calendar => 'Calendario';

  @override
  String get streak => 'Racha';

  @override
  String streakDays(Object days) {
    return 'Día $days';
  }

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get profile => 'Perfil';

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get notification => 'Notificaciones';

  @override
  String get notificationEnabled => 'Activar notificaciones';

  @override
  String get sound => 'Sonido';

  @override
  String get vibration => 'Vibración';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get dataReset => 'Restablecer datos';

  @override
  String get premium => 'Premium';

  @override
  String get premiumActive => '✅ Anuncios eliminados';

  @override
  String get removeAds => 'Eliminar anuncios';

  @override
  String get removeAdsDesc => 'Eliminar todos los anuncios permanentemente.';

  @override
  String get removeAdsBanner => 'Eliminar banners';

  @override
  String get removeAdsInterstitial => 'Eliminar intersticiales';

  @override
  String get removeAdsPermanent => 'Compra única, para siempre';

  @override
  String get purchase => 'Comprar';

  @override
  String get restore => 'Restaurar compra';

  @override
  String get restoringPurchase => 'Restaurando compras...';

  @override
  String get purchaseHistory => 'Historial de compras';

  @override
  String get noPurchaseHistory => 'Sin historial de compras';

  @override
  String get premiumUser => 'Premium activo ✨';

  @override
  String get version => 'Versión';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountConfirm =>
      '¿Estás seguro de eliminar tu cuenta?\nTodos los datos se eliminarán permanentemente.';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get logoutConfirm => '¿Cerrar sesión?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get delete => 'Eliminar';

  @override
  String get save => 'Guardar';

  @override
  String get ok => 'OK';

  @override
  String get customAmountTitle => 'Cantidad personalizada';

  @override
  String get customAmountHint => 'Ingresa cantidad en ml';

  @override
  String get add => 'Agregar';

  @override
  String get activityLevel => 'Nivel de actividad';

  @override
  String get wakeTime => 'Hora de despertar';

  @override
  String get sleepTime => 'Hora de dormir';

  @override
  String get mealTimes => 'Horarios de comida';

  @override
  String get breakfast => 'Desayuno';

  @override
  String get lunch => 'Almuerzo';

  @override
  String get dinner => 'Cena';

  @override
  String get language => 'Idioma';

  @override
  String get nickname => 'Apodo';

  @override
  String get notSet => 'Sin definir';

  @override
  String get goal => 'Meta';

  @override
  String get achievements => 'Logros';

  @override
  String get catPerfect => '¡Perfecto!';

  @override
  String get catHappy => '¡Bien!';

  @override
  String get catThirsty => 'Sed...';

  @override
  String get catCritical => '¡Peligro!';

  @override
  String get catNormal => 'Normal';

  @override
  String get connectionError => 'Sin conexión';

  @override
  String get retry => 'Reintentar';

  @override
  String get cups => 'vasos';

  @override
  String get onboardingNicknameRequired => '¡Dime tu nombre!';

  @override
  String get saveFailed => '¡Error al guardar!';

  @override
  String get deleteAccountFailed => 'Error al eliminar la cuenta.';

  @override
  String get activityLowDesc2 => 'Oficina, remoto';

  @override
  String get activityNormalDesc2 => 'Actividad normal';

  @override
  String get activityHighDesc2 => 'Ejercicio, aire libre';

  @override
  String activityFormula(Object n) {
    return 'Peso × ${n}ml';
  }

  @override
  String yearMonth(Object month, Object year) {
    return '$month/$year';
  }

  @override
  String consecutiveDays(Object n) {
    return '$n días seguidos';
  }

  @override
  String get keepGoing => '¡Genial! ¡Sigue así!';

  @override
  String get startToday => '¡Empieza hoy!';

  @override
  String get deleteRecord => 'Eliminar registro';

  @override
  String get deleteRecordConfirm => '¿Eliminar este registro?';

  @override
  String get removeBannerAds => 'Eliminar banners';

  @override
  String get removeFullAds => 'Eliminar anuncios de pantalla completa';

  @override
  String get permanentPurchase => 'Compra única, para siempre';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String get resetConfirm =>
      'Se eliminarán todos los registros de agua.\nSe mantendrá la info del perfil.';

  @override
  String get reset => 'Restablecer';

  @override
  String get removeAdsComplete => 'Anuncios eliminados';

  @override
  String get noPurchases => 'Sin compras';

  @override
  String get purchaseHint =>
      'Compra la eliminación de anuncios para verlo aquí';

  @override
  String get resetNotSupported => 'Restablecimiento de datos próximamente.';

  @override
  String get dailyGoal => 'Meta diaria';

  @override
  String get catMessageNormal1 => '¡Hora del agua~!';

  @override
  String get catMessageNormal2 => '¡Mantente saludable!';

  @override
  String get catMessageNormal3 => '¿Un vasito?';

  @override
  String get catMessageHappy1 => '¡Muy bien! 👏';

  @override
  String get catMessageHappy2 => '¡Gran hábito!';

  @override
  String get catMessageHappy3 => '¡Sigue así!';

  @override
  String get catMessageThirsty1 => 'Tengo sed... 💧';

  @override
  String get catMessageThirsty2 => '¡Agua por favor...!';

  @override
  String get catMessageThirsty3 => 'Sequedad... ¡agua!';

  @override
  String get catMessageCritical1 => '¡Peligro! ¡Bebe ahora! 🚨';

  @override
  String get catMessageCritical2 => '¡Por favor... agua...!';

  @override
  String get catMessagePerfect1 => '¡Perfecto! ¡Héroe del día! 🏆';

  @override
  String get catMessagePerfect2 => '¡Meta lograda! ¡Increíble!';

  @override
  String get weekMon => 'Lun';

  @override
  String get weekTue => 'Mar';

  @override
  String get weekWed => 'Mié';

  @override
  String get weekThu => 'Jue';

  @override
  String get weekFri => 'Vie';

  @override
  String get weekSat => 'Sáb';

  @override
  String get weekSun => 'Dom';

  @override
  String get average => 'Prom';

  @override
  String dateFormat(Object day, Object month, Object weekday) {
    return '$weekday $day/$month';
  }
}
