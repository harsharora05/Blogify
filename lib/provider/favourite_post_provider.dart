import 'package:blog/model/post_model.dart';
import 'package:flutter/material.dart';

class Favouritepostprovider extends ChangeNotifier {
  List<Post> favPosts = [];

  Future<bool> toggleFavPosts(Post post) async {
    bool isContain = favPosts.any((favPost) => favPost.id == post.id);
    if (!isContain || favPosts.isEmpty) {
      favPosts.add(post);
      notifyListeners();
      return true;
    } else {
      favPosts
          .removeWhere((favPost) => favPost.id == post.id); // Remove post by id
      notifyListeners();
      return false;
    }
  }

  bool isPostFavorited(int postId) {
    return favPosts.any((favPost) => favPost.id == postId);
  }
}
