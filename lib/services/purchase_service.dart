import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ad_service.dart';
import 'api_service.dart';

class PurchaseService {
  static final PurchaseService _instance = PurchaseService._();
  factory PurchaseService() => _instance;
  PurchaseService._();

  static const String removeAdsId = 'remove_ads';
  static const String _premiumKey = 'is_premium';

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  bool _isPremium = false;
  bool _available = false;
  ProductDetails? _product;

  bool get isPremium => _isPremium;
  bool get available => _available && _product != null;
  String get price => _product?.price ?? '₩1,900';
  ProductDetails? get product => _product;

  final _premiumController = StreamController<bool>.broadcast();
  Stream<bool> get premiumStream => _premiumController.stream;

  Future<void> init() async {
    if (kIsWeb) return;

    // Restore saved premium status
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool(_premiumKey) ?? false;
    if (_isPremium) {
      AdService().setPremium(true);
      _premiumController.add(true);
    }

    _available = await _iap.isAvailable();
    if (!_available) return;

    // Listen to purchases
    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdate,
      onDone: () => _subscription?.cancel(),
      onError: (_) {},
    );

    // Load product
    final response = await _iap.queryProductDetails({removeAdsId});
    if (response.productDetails.isNotEmpty) {
      _product = response.productDetails.first;
    }
  }

  Future<void> buyRemoveAds() async {
    if (_product == null || _isPremium) return;

    final purchaseParam = PurchaseParam(productDetails: _product!);
    // Non-consumable (permanent ad removal)
    await _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        if (purchase.productID == removeAdsId) {
          // Verify and record on server first
          try {
            final receipt = Platform.isAndroid
                ? purchase.verificationData.serverVerificationData
                : purchase.verificationData.serverVerificationData;
            await ApiService().dio.post('/purchase', data: {
              'productId': removeAdsId,
              'platform': Platform.isAndroid ? 'android' : 'ios',
              'price': int.tryParse(_product?.rawPrice.toStringAsFixed(0) ?? '1900') ?? 1900,
              'transactionId': purchase.purchaseID,
              'receipt': receipt,
            });
          } catch (_) {}
          await _setPremium(true);
        }
      }

      if (purchase.pendingCompletePurchase) {
        await _iap.completePurchase(purchase);
      }
    }
  }

  Future<void> _setPremium(bool value) async {
    _isPremium = value;
    AdService().setPremium(value);
    _premiumController.add(value);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_premiumKey, value);
  }

  void dispose() {
    _subscription?.cancel();
    _premiumController.close();
  }
}
