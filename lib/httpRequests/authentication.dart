import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const tokenStorage = FlutterSecureStorage();

Future<Map<String, dynamic>> signUp(
    String username, String email, String pass, String confirmPass) async {
  var url = Uri.https('solobloger-api.onrender.com', 'api-auth/register/');

  try {
    var response = await http.post(url, body: {
      'username': username,
      'email': email,
      'password': pass,
      'password2': confirmPass
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      tokenStorage.write(key: "token", value: jsonResponse["token"]);

      return {
        "isLoggedIn": true,
        "username": jsonResponse["username"],
        "email": jsonResponse["email"],
        "message": "login",
        "status": "success"
      };
    } else {
      throw response.statusCode;
    }
  } catch (e) {
    return {
      "isLoggedIn": false,
      "username": "Guest",
      "email": "",
      "status": e,
      "message": "Failed to sign up. Please try again."
    };
  }
}

Future<Map<String, dynamic>> login(String username, String pass) async {
  var url = Uri.https('solobloger-api.onrender.com', 'api-auth/login/');

  try {
    var response = await http.post(url, body: {
      'username': username,
      'password': pass,
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      tokenStorage.write(key: "token", value: jsonResponse["token"]);
      return {
        "isLoggedIn": true,
        "username": jsonResponse["username"],
        "email": jsonResponse["email"],
        "message": "login",
        "status": "success"
      };
    } else if (response.statusCode == 401) {
      return {
        "isLoggedIn": false,
        "username": "Guest",
        "email": "",
        "status": "Failed",
        "message": 'Invalid credentials.'
      };
    } else {
      throw response.statusCode;
    }
  } catch (e) {
    return {
      "isLoggedIn": false,
      "username": "Guest",
      "email": "",
      "status": e,
      "message": "Login failed. Please try again."
    };
  }
}

Future<Map<String, dynamic>> logout() async {
  final token = await tokenStorage.read(key: "token");

  var url = Uri.https("solobloger-api.onrender.com", "api-auth/logout/");
  try {
    var response = await http.post(url, headers: {
      'Content-type': 'application/json',
      "Authorization": "token $token"
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return {
        "isLoggedIn": false,
        "username": "Guest",
        "email": "",
        "message": jsonResponse["message"],
        "status": "success"
      };
    } else {
      return {
        "isLoggedIn": false,
        "username": "",
        "email": "",
        "message": "Failed to log out, server error",
        "status": "failed"
      };
    }
  } catch (e) {
    return {
      "isLoggedIn": false,
      "username": "",
      "email": "",
      "message": "Logout api error",
      "status": "failed"
    };
  }
}
