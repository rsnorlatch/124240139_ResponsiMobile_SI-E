import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  static const String _prefsKey = 'isLoggedIn';
  static const String _usernameKey = 'loggedInUsername';

  static const String correctUsername = 'faris';
  static const String correctPassword = '139';

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool _isLoggedIn = false.obs;
  bool get isLoggedIn => _isLoggedIn.value;

  @override
  void onInit() {
    _loadLoginStatus();
    super.onInit();
  }

  Future<void> _loadLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn.value = prefs.getBool(_prefsKey) ?? false;
  }

  /// Reads the persisted login status from shared_preferences.
  Future<bool> getInitialLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefsKey) ?? false;
  }

  /// Returns true when credentials are correct and persists the login state.
  Future<bool> login(String username, String password) async {
    if (username == correctUsername && password == correctPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefsKey, true);
      await prefs.setString(_usernameKey, username);
      _isLoggedIn.value = true;
      return true;
    }
    return false;
  }

  /// Clears the persisted login state.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
    await prefs.remove(_usernameKey);
    _isLoggedIn.value = false;
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
