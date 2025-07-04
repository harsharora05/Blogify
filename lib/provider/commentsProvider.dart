import 'package:blog/httpRequests/commentsRequests.dart';
import 'package:blog/model/commentsModel.dart';
import 'package:flutter/material.dart';

class CommentsProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Comment> comments = [];

  Future<void> getComments(String postId) async {
    isLoading = true;
    notifyListeners();

    try {
      comments = await initializeComments(postId);
    } catch (e) {
      // Optional: handle error, e.g., show a snackbar or log
      comments = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> commentAddP(
      String content, String postId) async {
    try {
      var res = await addComment(postId, content);
      if (res["statusCode"] == 200) {
        Comment cmt = Comment.fromJson(res["comment"]);
        comments.insert(0, cmt);
      }
      return {"statusCode": res["statusCode"], "message": res["message"]};
    } catch (e) {
      print("someError occurred ${e}");
      return {"statusCode": "500", "message": "Some Error Occured"};
    } finally {
      notifyListeners();
    }
  }
}
