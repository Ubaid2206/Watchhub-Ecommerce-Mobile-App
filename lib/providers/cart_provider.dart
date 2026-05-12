import 'package:flutter/foundation.dart';
import '../models/watch_model.dart';

class CartItem {
  final WatchModel watch;
  int quantity;

  CartItem({required this.watch, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    for (var item in _items) {
      total += item.watch.price * item.quantity;
    }
    return total;
  }

  void addToCart(WatchModel watch) {
    final existingIndex = _items.indexWhere((item) => item.watch.id == watch.id);
    
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(watch: watch));
    }
    notifyListeners();
  }

  void removeFromCart(String watchId) {
    _items.removeWhere((item) => item.watch.id == watchId);
    notifyListeners();
  }

  void updateQuantity(String watchId, int quantity) {
    final index = _items.indexWhere((item) => item.watch.id == watchId);
    if (index >= 0) {
      if (quantity > 0) {
        _items[index].quantity = quantity;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool isInCart(String watchId) {
    return _items.any((item) => item.watch.id == watchId);
  }
}