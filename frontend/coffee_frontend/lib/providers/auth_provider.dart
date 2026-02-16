import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  bool _isAuthenticated = false;
  final ApiService _apiService = ApiService();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login(String email, String password) async {
    try {
      final response = await _apiService.login(email, password);
      _token = response.data['access'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', _token!);
      _isAuthenticated = true;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    _token = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('access_token');
    _isAuthenticated = _token != null;
    notifyListeners();
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;

      if (accessToken == null) return false;

      final response = await _apiService.dio.post('auth/google/', data: {
        'access_token': accessToken,
      });

      _token = response.data['access_token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', _token!);
      _isAuthenticated = true;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
