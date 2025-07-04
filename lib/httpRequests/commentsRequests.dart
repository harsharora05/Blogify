import 'dart:convert';

import 'package:blog/model/commentsModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

var userStorage = FlutterSecureStorage();

Future<List<Comment>> initializeComments(String postId) async {
  var url = Uri.http('10.0.2.2:3000', '/v1/comment/${postId}');

  try {
    var token = await userStorage.read(key: 'token');
    var response = await http.get(url, headers: {"token": token.toString()});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<Comment> comments = (jsonResponse["comments"] as List<dynamic>)
          .map((json) => Comment.fromJson(json))
          .toList();

      return comments;
    } else {
      throw "Cant load post";
    }
  } catch (e) {
    return [];
  }
}

Future<Map<String, dynamic>> addComment(String postId, String Content) async {
  var url = Uri.http('10.0.2.2:3000', '/v1/comment/${postId}');

  try {
    var token = await userStorage.read(key: 'token');

    var response = await http.post(url,
        body: {"content": Content}, headers: {"token": token.toString()});
    var jsonResponse = jsonDecode(response.body);

    return {
      "statusCode": response.statusCode,
      "message": jsonResponse["message"],
      "comment": jsonResponse["comment"]
    };
  } catch (e) {
    return {"statusCode": 500, "message": "Some Error Occured"};
  }
}
