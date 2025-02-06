import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const userStorage = FlutterSecureStorage();

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
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      userStorage.write(key: "token", value: jsonResponse["token"]);
      userStorage.write(key: "username", value: jsonResponse["username"]);
      return {
        "isLoggedIn": true,
        "username": jsonResponse["username"],
        "email": jsonResponse["email"],
        "message": jsonResponse["message"],
        "status": response.statusCode
      };
    } else if (response.statusCode == 400) {
      // beacuse serializer.validation error is returning status 400 otherwise we would have kept it 401
      return {
        "isLoggedIn": false,
        "username": "Guest",
        "email": "",
        "message": jsonResponse["message"] ?? jsonResponse["username"][0],
        "status": response.statusCode
      };
    } else {
      throw (response.statusCode);
    }
  } catch (e) {
    return {
      "isLoggedIn": false,
      "username": "Guest",
      "email": "",
      "message": "Failed to sign up. Please try again.",
      "status": e,
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

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      userStorage.write(key: "token", value: jsonResponse["token"]);
      userStorage.write(key: "username", value: jsonResponse["username"]);
      return {
        "isLoggedIn": true,
        "username": jsonResponse["username"],
        "email": jsonResponse["email"],
        "message": jsonResponse["message"],
        "status": response.statusCode
      };
    } else if (response.statusCode == 401) {
      return {
        "isLoggedIn": false,
        "username": "Guest",
        "email": "",
        "message": jsonResponse["message"],
        "status": response.statusCode
      };
    } else {
      throw response.statusCode;
    }
  } catch (e) {
    return {
      "isLoggedIn": false,
      "username": "Guest",
      "email": "",
      "message": "Login failed. Please try again.",
      "status": e
    };
  }
}

Future<Map<String, dynamic>> logout() async {
  final token = await userStorage.read(key: "token");

  var url = Uri.https("solobloger-api.onrender.com", "api-auth/logout/");
  try {
    var response = await http.post(url, headers: {
      'Content-type': 'application/json',
      "Authorization": "token $token"
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      userStorage.write(key: "token", value: "");
      userStorage.write(key: "username", value: "Guest");

      return {
        "isLoggedIn": false,
        "username": "Guest",
        "email": "",
        "message": jsonResponse["message"],
        "status": response.statusCode
      };
    } else {
      return {
        "isLoggedIn": false,
        "username": "",
        "email": "",
        "message": "Failed to log out, server error",
        "status": response.statusCode
      };
    }
  } catch (e) {
    return {
      "isLoggedIn": false,
      "username": "",
      "email": "",
      "message": "Logout api error",
      "status": 400
    };
  }
}
