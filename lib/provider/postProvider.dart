import 'package:blog/httpRequests/postsRequest.dart';
import 'package:blog/model/post_model.dart';
import 'package:flutter/material.dart';

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

  Future<void> AddNextRecentPosts(List<Post> nextPosts) async {
    recentPosts += nextPosts;
    notifyListeners();
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
      print(popularPosts);
    } catch (e) {
      errorMessage = "Failed to load posts: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
