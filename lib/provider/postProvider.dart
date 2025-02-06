import 'dart:math';

import 'package:blog/httpRequests/postsRequest.dart';
import 'package:blog/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

var userStorage = FlutterSecureStorage();

class RecentPostProvider extends ChangeNotifier {
  List<Post> recentPosts = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> InitialRecentPosts() async {
    errorMessage = null;
    notifyListeners();

    try {
      isLoading = true;
      recentPosts = await getRecentPost();
    } catch (e) {
      errorMessage = "Failed to load posts: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> tagsPost(String tag) async {
    recentPosts = [];
    errorMessage = null;
    notifyListeners();

    try {
      isLoading = true;
      recentPosts = await getTagPosts(tag);
    } catch (e) {
      errorMessage = "Failed to load posts: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> AddNextRecentPosts(List<Post> nextPosts) async {
    recentPosts += nextPosts;
    notifyListeners();
  }

  Future<void> AddPost(
      String title, String content, String category, XFile image) async {
    final username = await userStorage.read(key: "username");
    Random random = new Random();
    Post postToUpload = Post(
        content: content,
        photo: "null",
        title: title,
        username: username!,
        category: category,
        likes: 0,
        id: random.nextInt(20000000));
    recentPosts.add(postToUpload);
    uploadPost(title, content, category, image);
  }
}

class PopularPostProvider extends ChangeNotifier {
  String? errorMessage;
  bool isLoading = false;
  List<Post> popularPosts = [];

  Future<void> InitialPopularPosts() async {
    errorMessage = null;
    notifyListeners();
    try {
      isLoading = true;
      popularPosts = await getPopularPost();
      // print(popularPosts);
    } catch (e) {
      errorMessage = "Failed to load posts: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
