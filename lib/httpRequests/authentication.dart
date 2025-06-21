import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const userStorage = FlutterSecureStorage();

Future<Map<String, dynamic>> signUp(String name, String username, String email,
    String pass, String confirmPass) async {
  var url = Uri.http('10.0.2.2:3000', '/v1/user/signUp');

  try {
    var response = await http.post(url, body: {
      'name': name,
      'username': username,
      'email': email,
      'password': pass,
      'confirmPassword': confirmPass
    });
    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        "message": jsonResponse["message"],
        "status": response.statusCode
      };
    } else if (response.statusCode == 400) {
      return {
        "message": jsonResponse["message"],
        "status": response.statusCode
      };
    } else {
      throw (response.statusCode);
    }
  } catch (e) {
    print(e);
    return {
      "message": "Failed to sign up. Please try again.",
      "status": e,
    };
  }
}

Future<Map<String, dynamic>> login(String email, String pass) async {
  var url = Uri.http('10.0.2.2:3000', '/v1/user/signIn');

  try {
    var response = await http.post(url, body: {
      'email': email,
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
    } else if (response.statusCode == 400) {
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

Map<String, dynamic> logout() {
  userStorage.write(key: "token", value: "");
  userStorage.write(key: "username", value: "Guest");

  return {
    "isLoggedIn": false,
    "username": "Guest",
    "email": "",
    "message": "Logout Successfull",
    "status": 200
  };
}

Future<Map<String, dynamic>> changePassword(
    String oldPassword, String newPassword, String confirmNewPassword) async {
  print("in function");
  var url = Uri.http('10.0.2.2:3000', '/v1/user/changePassword');
  var token = await userStorage.read(key: "token");
  try {
    var response = await http.post(url, body: {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      "confirmNewPassword": confirmNewPassword
    }, headers: {
      "token": token!
    });

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    return {"message": jsonResponse["message"], "status": response.statusCode};
  } catch (e) {
    return {"message": "Something Went Wrong", "status": 500};
  }
}
