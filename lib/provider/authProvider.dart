import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authprovider extends ChangeNotifier {
  bool? _isLoggedIn;
  // late Future<String?> _authToken;
  String? username;
  String? email;

  Future<void> initializeData() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('isLoggedIn') == null &&
        prefs.getString('username') == null &&
        prefs.getString('email') == null) {
      await prefs.setBool('isLoggedIn', false);
      await prefs.setString('username', "Guest");
      await prefs.setString('email', "");
      await prefs.setString("message", "not login");
      await prefs.setString("status", "Not Login");

      _isLoggedIn = false;
      username = "Guest";
      email = "";
      // _authToken = "" as Future<String>;
      notifyListeners();
    } else {
      _isLoggedIn = prefs.getBool('isLoggedIn');
      username = prefs.getString('username');
      email = prefs.getString('email');
      notifyListeners();
    }
  }

  bool? getIslogin() => _isLoggedIn;

  Future<void> saveData(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();

    _isLoggedIn = user["isLoggedIn"];
    // print(user["isLoggedIn"]);
    username = user["username"];
    email = user["email"];

    await prefs.setBool('isLoggedIn', _isLoggedIn!);
    await prefs.setString("username", username!);
    await prefs.setString("email", email!);

    notifyListeners();
  }
}
