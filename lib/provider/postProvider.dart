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

  Future<Map<String, dynamic>> AddPost(
      String title, String content, String category, XFile image) async {
    var username = await userStorage.read(key: "username");
    Map<String, dynamic> res =
        await uploadPost(title, content, category, image);
    if (res["status"] == 200) {
      recentPosts.insert(
          0,
          Post(
              content: res["post"]["content"],
              photo: res["post"]["image"],
              title: res["post"]["title"],
              username: username.toString(),
              category: res["post"]["category"],
              createdAt: res["post"]["createdAt"],
              likes: res["post"]["likes"],
              id: res["post"]["_id"]));
      notifyListeners();
    }
    return res;
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
    } catch (e) {
      errorMessage = "Failed to load posts: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
