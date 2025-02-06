import 'dart:async';
import 'dart:convert';

import 'package:blog/model/post_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

late String NextUrl;
var userStorage = FlutterSecureStorage();

Future<List<Post>> getRecentPost() async {
  var url = Uri.https("solobloger-api.onrender.com", "api/recent_blog/");

  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      // print(jsonResponse);
      NextUrl = jsonResponse["next"].toString();
      List<Post> posts = (jsonResponse["results"] as List<dynamic>)
          .map((json) => Post.fromJson(json))
          .toList();

      return posts;
    } else {
      throw "Cant load post";
    }
  } catch (e) {
    return [];
  }
}

Future<List<Post>> loadMorePosts() async {
  // Check if NextUrl is null or "null"
  if (NextUrl.toLowerCase() == "null") {
    // print('No more posts to load. NextUrl is null.');
    return [];
  }

  var url = Uri.parse(NextUrl);
  // print('Fetching posts from: $url');

  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      // Parse posts from JSON response
      List<Post> posts = (jsonResponse["results"] as List<dynamic>)
          .map((json) => Post.fromJson(json))
          .toList();

      // Update NextUrl
      NextUrl = jsonResponse["next"].toString();
      // print('Next URL: $NextUrl');
      // print('Fetched posts: $posts');

      return posts;
    } else {
      // print('Failed to load posts. Status code: ${response.statusCode}');
      throw Exception("Can't load posts");
    }
  } catch (e) {
    print('Error occurred: $e');
    return [];
  }
}

Future<List<Post>> getPopularPost() async {
  var url = Uri.https("solobloger-api.onrender.com", "api/popular_blog/");
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      List<Post> posts = (jsonResponse as List<dynamic>)
          .map((json) => Post.fromJson(json))
          .toList();
      return posts;
    } else {
      throw "Cant load post";
    }
  } catch (e) {
    return [];
  }
}

Future<List<Post>> getTagPosts(String tag) async {
  var url = Uri.https(
      "solobloger-api.onrender.com", "api/search_blog/", {"search": tag});
  var response = await http.get(url);
  // print(response.body);
  try {
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      // print(jsonResponse);
      List<Post> posts = (jsonResponse['results'] as List<dynamic>)
          .map((json) => Post.fromJson(json))
          .toList();
      return posts;
    } else {
      throw "Cant load post";
    }
  } catch (e) {
    return [];
  }
}

void uploadPost(
    String title, String content, String category, XFile image) async {
  var url = Uri.https("Solobloger-api.onrender.com", "api/create_blog/");
  var token = await userStorage.read(key: "token");
  print(token);
  final request = await http.MultipartRequest('POST', url);

  request.headers.addAll({"Authorization": "token ${token.toString()}"});
  request.fields['title'] = title;
  request.fields['content'] = content;
  request.fields['category'] = category.toUpperCase();
  var imageFile = await http.MultipartFile.fromPath('img', image.path);
  request.files.add(imageFile);
  var response = await request.send();
  // Check the response
  if (response.statusCode == 200) {
    // If the upload is successful, print the response body
    var responseBody = await response.stream.bytesToString();
    print("Response: ${jsonDecode(responseBody)}");
  } else {
    // Handle errors
    print("Failed to upload image. Status: ${response.statusCode}");
  }
}
