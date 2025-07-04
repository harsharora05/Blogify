import 'package:blog/httpRequests/postsRequest.dart';
import 'package:blog/model/post_model.dart';
import 'package:flutter/material.dart';

class Favouritepostprovider extends ChangeNotifier {
  List<FavPost> favPosts = [];

  Future<bool> toggleFavPosts(dynamic post) async {
    bool isContain = favPosts.any((favPost) => favPost.id == post.id);
    if (!isContain || favPosts.isEmpty) {
      var newFavPost = FavPost(
          createdAt: post.createdAt,
          content: post.content,
          photo: post.photo,
          title: post.title,
          username: post.username,
          category: post.category,
          likes: post.likes,
          id: post.id);
      var status = await addFavPost(newFavPost.id);
      if (status == 200) {
        favPosts.add(newFavPost);
        notifyListeners();
      }

      return true;
    } else {
      var status = await removeFavPost(post.id);
      if (status == 200) {
        favPosts.removeWhere(
            (favPost) => favPost.id == post.id); // Remove post by id
        notifyListeners();
      }

      return false;
    }
  }

  bool isPostFavorited(String postId) {
    return favPosts.any((favPost) => favPost.id == postId);
  }

  Future<void> InitialFavPosts() async {
    try {
      List<FavPost> post = await getFavPosts();
      favPosts = post;
    } catch (e) {
      print("Failed to load posts: $e");
    } finally {
      notifyListeners();
    }
  }
}
