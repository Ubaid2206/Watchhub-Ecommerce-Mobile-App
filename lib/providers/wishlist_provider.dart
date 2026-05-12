import 'package:flutter/foundation.dart';
import '../models/watch_model.dart';

class WishlistProvider with ChangeNotifier {
  final List<WatchModel> _items = [];

  List<WatchModel> get items => _items;

  int get itemCount => _items.length;

  void addToWishlist(WatchModel watch) {
    if (!_items.any((item) => item.id == watch.id)) {
      _items.add(watch);
      notifyListeners();
    }
  }

  void removeFromWishlist(String watchId) {
    _items.removeWhere((item) => item.id == watchId);
    notifyListeners();
  }

  bool isInWishlist(String watchId) {
    return _items.any((item) => item.id == watchId);
  }

  void clearWishlist() {
    _items.clear();
    notifyListeners();
  }
}