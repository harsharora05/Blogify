import 'dart:async';
import 'dart:convert';

import 'package:blog/model/post_model.dart';
import 'package:http/http.dart' as http;

late String NextUrl;

Future<List<Post>> getRecentPost() async {
  var url = Uri.https("solobloger-api.onrender.com", "api/recent_blog/");

  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
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
