import 'package:flutter/material.dart';
import 'package:notifications/model/cart_model.dart';
import 'package:notifications/model/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartModel> _shoppingCart = [];
  final Set<String> _selectedItems = {}; // To keep track of selected items

  void addToCart(ProductModel product) {
    var isExist = _shoppingCart.where(
      (element) => element.product.id == product.id,
    );
    if (isExist.isEmpty) {
      _shoppingCart.add(CartModel(product: product, quantity: 1));
    } else {
      isExist.first.quantity += 1;
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _shoppingCart.removeWhere((element) => element.id == productId);
    _selectedItems.remove(productId); // Also remove from selected items
    notifyListeners();
  }

  void incrementQty(String productId) {
    CartModel item = _shoppingCart
        .where((element) => element.id == productId)
        .first;
    item.quantity++;
    notifyListeners();
  }

  void decrimentQty(String productId) {
    CartModel item = _shoppingCart
        .where((element) => element.id == productId)
        .first;

    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _shoppingCart.remove(item);
      _selectedItems.remove(productId); // Remove from selected items too
    }
    notifyListeners();
  }

  double getCartTotal() {
    double total = 0;
    for (var cartItem in _shoppingCart) {
      total += (cartItem.product.price * cartItem.quantity);
    }
    return total;
  }

  double getSelectedItemsTotal() {
    double total = 0;
    for (var cartItem in _shoppingCart) {
      if (_selectedItems.contains(cartItem.id)) {
        total += (cartItem.product.price * cartItem.quantity);
      }
    }
    return total;
  }

  void toggleSelection(String productId) {
    if (_selectedItems.contains(productId)) {
      _selectedItems.remove(productId);
    } else {
      _selectedItems.add(productId);
    }
    notifyListeners();
  }

  bool hasSelectedItems() {
    return _shoppingCart.any((item) => _selectedItems.contains(item.id));
  }

  bool isSelected(String productId) {
    return _selectedItems.contains(productId);
  }

  // NEW: Clear entire cart
  void clearCart() {
    _shoppingCart.clear();
    _selectedItems.clear();
    notifyListeners();
  }

  // NEW: Clear only selected items (useful for partial checkout)
  void clearSelectedItems() {
    _shoppingCart.removeWhere((item) => _selectedItems.contains(item.id));
    _selectedItems.clear();
    notifyListeners();
  }

  // NEW: Select all items
  void selectAllItems() {
    _selectedItems.clear();
    for (var item in _shoppingCart) {
      _selectedItems.add(item.id);
    }
    notifyListeners();
  }

  // NEW: Deselect all items
  void deselectAllItems() {
    _selectedItems.clear();
    notifyListeners();
  }

  // NEW: Get selected items as a list
  List<CartModel> getSelectedItems() {
    return _shoppingCart
        .where((item) => _selectedItems.contains(item.id))
        .toList();
  }

  // NEW: Get total quantity of items in cart
  int get totalItemsInCart {
    return _shoppingCart.fold(0, (total, item) => total + item.quantity);
  }

  // NEW: Get total quantity of selected items
  int get totalSelectedItems {
    return _shoppingCart
        .where((item) => _selectedItems.contains(item.id))
        .fold(0, (total, item) => total + item.quantity);
  }

  // Existing getters
  List<CartModel> get shoppingCart => _shoppingCart;
  double get cartSubTotal => getCartTotal();
  double get shippingCharge => 10;
  double get cartTotal => cartSubTotal + shippingCharge;
  double get selectedItemsTotal => getSelectedItemsTotal();
  double get totalCart => getSelectedItemsTotal() + shippingCharge;
}
