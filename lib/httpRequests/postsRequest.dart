import 'dart:async';
import 'dart:convert';

import 'package:blog/model/post_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

late String NextUrl;
var userStorage = FlutterSecureStorage();

Future<List<Post>> getRecentPost() async {
  var url = Uri.http("10.0.2.2:3000", "/v1/blogs");
  var token = await userStorage.read(key: "token");

  try {
    var response = await http.get(url, headers: {"token": token.toString()});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      // NextUrl = jsonResponse["next"].toString();
      List<Post> posts = (jsonResponse["blogs"] as List<dynamic>)
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
  var url = Uri.http("10.0.2.2:3000", "/v1/famousBlogs");
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<Post> posts = (jsonResponse["famousBlogs"] as List<dynamic>)
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
  var url = Uri.http("10.0.2.2:3000", "/v1/Blogs/$tag");
  var response = await http.get(url);
  try {
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<Post> posts = (jsonResponse["blogs"] as List<dynamic>)
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

Future<Map<String, dynamic>> uploadPost(
    String title, String content, String category, XFile image) async {
  var url = Uri.http("10.0.2.2:3000", "/v1/blog");
  var token = await userStorage.read(key: "token");
  final request = http.MultipartRequest('POST', url);

  request.headers.addAll({"token": token.toString()});
  request.fields['title'] = title;
  request.fields['content'] = content;
  request.fields['category'] = category;
  var imageFile = await http.MultipartFile.fromPath('image', image.path);
  request.files.add(imageFile);
  var response = await request.send();
  var responseBody = await response.stream.bytesToString();
  var res = jsonDecode(responseBody);
  // Check the response
  if (response.statusCode == 200) {
    return ({
      "status": response.statusCode,
      "message": res["message"],
      "post": res["post"]
    });
  } else if (response.statusCode == 400) {
    return ({
      "status": response.statusCode,
      "message": res["message"],
    });
  } else {
    // Handle errors
    return ({
      "status": response.statusCode,
      "message": "Failed to upload the post!!! Try Again Later.."
    });
  }
}

Future<List<FavPost>> getFavPosts() async {
  var url = Uri.http("10.0.2.2:3000", "/v1/favBlogs");
  var token = await userStorage.read(key: "token");
  try {
    var response = await http.get(url, headers: {"token": token.toString()});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<FavPost> favPosts = (jsonResponse["favPost"] as List<dynamic>)
          .map((json) => FavPost.fromJson(json))
          .toList();
      return favPosts;
    } else {
      throw "Cant load post";
    }
  } catch (e) {
    return [];
  }
}

Future<int> addFavPost(String id) async {
  var url = Uri.http("10.0.2.2:3000", "/v1/favBlog/${id}");
  var token = await userStorage.read(key: "token");
  try {
    var response = await http.post(url, headers: {"token": token.toString()});
    return response.statusCode;
  } catch (e) {
    return 500;
  }
}

Future<int> removeFavPost(String id) async {
  var url = Uri.http("10.0.2.2:3000", "/v1/favBlog/${id}");
  var token = await userStorage.read(key: "token");
  try {
    var response = await http.delete(url, headers: {"token": token.toString()});
    return response.statusCode;
  } catch (e) {
    return 500;
  }
}
