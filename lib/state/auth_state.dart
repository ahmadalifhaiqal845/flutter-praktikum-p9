import 'package:flutter/foundation.dart';

class CartItem {
  const CartItem({required this.productId, required this.quantity});

  final int productId;
  final int quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(productId: productId, quantity: quantity ?? this.quantity);
  }
}

class AuthState extends ChangeNotifier {
  String? _username;
  final Map<int, CartItem> _cart = {};

  String? get username => _username;
  bool get isLoggedIn => _username != null;
  List<CartItem> get cartItems => _cart.values.toList();

  void login(String username) {
    final normalizedUsername = username.trim();
    if (normalizedUsername.isEmpty) return;
    _username = normalizedUsername;
    notifyListeners();
  }

  void logout() {
    if (!isLoggedIn) return;
    _username = null;
    _cart.clear();
    notifyListeners();
  }

  void addToCart(int productId) {
    final current = _cart[productId];
    if (current == null) {
      _cart[productId] = CartItem(productId: productId, quantity: 1);
    } else {
      _cart[productId] = current.copyWith(quantity: current.quantity + 1);
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    if (_cart.containsKey(productId)) {
      final current = _cart[productId]!;
      if (current.quantity <= 1) {
        _cart.remove(productId);
      } else {
        _cart[productId] = current.copyWith(quantity: current.quantity - 1);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    if (_cart.isEmpty) return;
    _cart.clear();
    notifyListeners();
  }
}
