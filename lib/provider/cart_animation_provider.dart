import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';

class CartAnimationProvider with ChangeNotifier {
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  Function(GlobalKey)? runAddToCartAnimation;
  var _cartQuantityItems = 0;

  GlobalKey<CartIconKey> get getCartKey => cartKey;
  int get cartQuantityItems => _cartQuantityItems;

  void setAddToCartAnimation(Function(GlobalKey) callback) {
    runAddToCartAnimation = callback;
  }

  Future<void> addToCartClick(GlobalKey widgetKey) async {
    if (runAddToCartAnimation != null) {
      await runAddToCartAnimation!(widgetKey);
      await cartKey.currentState!
          .runCartAnimation((++_cartQuantityItems).toString());
      notifyListeners();
    }
  }

  void clearCart() {
    _cartQuantityItems = 0;
    cartKey.currentState!.runClearCartAnimation();
    notifyListeners();
  }
}
