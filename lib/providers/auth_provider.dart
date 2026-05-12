import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoggedIn = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;

  // Login
  Future<bool> login(String email, String password) async {
    try {
      // Dummy login - backend se replace karein
      await Future.delayed(const Duration(seconds: 2));
      
      _currentUser = UserModel(
        id: '1',
        name: 'John Doe',
        email: email,
        phone: '+92 300 1234567',
        profileImage: 'https://via.placeholder.com/150',
        addresses: ['House 123, Street ABC, Karachi'],
      );
      
      _isLoggedIn = true;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Sign Up
  Future<bool> signUp(String name, String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      
      _currentUser = UserModel(
        id: '1',
        name: name,
        email: email,
      );
      
      _isLoggedIn = true;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Logout
  void logout() {
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  // Update Profile
  void updateProfile(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }
}