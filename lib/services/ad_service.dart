import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static final AdService _instance = AdService._();
  factory AdService() => _instance;
  AdService._();

  bool _initialized = false;
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  bool _isPremium = false;

  // Test ad unit IDs (replace with real ones for production)
  static const String _bannerAdUnitId = kDebugMode
      ? 'ca-app-pub-3940256099942544/6300978111' // Google test
      : 'ca-app-pub-XXXXX/YYYYY'; // TODO: Replace with real ID

  static const String _interstitialAdUnitId = kDebugMode
      ? 'ca-app-pub-3940256099942544/1033173712' // Google test
      : 'ca-app-pub-XXXXX/ZZZZZ'; // TODO: Replace with real ID

  Future<void> init() async {
    if (_initialized || kIsWeb) return; // Skip on web
    try {
      await MobileAds.instance.initialize();
      _initialized = true;
    } catch (_) {}
  }

  void setPremium(bool isPremium) {
    _isPremium = isPremium;
    if (_isPremium) {
      _bannerAd?.dispose();
      _bannerAd = null;
      _interstitialAd?.dispose();
      _interstitialAd = null;
    }
  }

  /// Load banner ad
  BannerAd? loadBannerAd() {
    if (_isPremium || !_initialized) return null;

    _bannerAd?.dispose();
    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _bannerAd = null;
        },
      ),
    )..load();

    return _bannerAd;
  }

  /// Load interstitial (shown between actions)
  Future<void> loadInterstitial() async {
    if (_isPremium || !_initialized) return;

    await InterstitialAd.load(
      adUnitId: _interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (error) => _interstitialAd = null,
      ),
    );
  }

  /// Show interstitial if loaded
  Future<void> showInterstitial() async {
    if (_isPremium || _interstitialAd == null) return;
    await _interstitialAd!.show();
    _interstitialAd = null;
    // Preload next
    loadInterstitial();
  }

  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
  }
}
