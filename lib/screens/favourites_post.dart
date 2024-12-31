import "package:blog/data/post_data.dart";
import "package:blog/widgets/RecentPostCard.dart";
import "package:flutter/material.dart";

class FavouritePost extends StatelessWidget {
  const FavouritePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
      ),
      body: ListView.builder(
          itemCount: dummyPosts.length,
          itemBuilder: (context, index) {
            final post = dummyPosts[index];
            return RecentPostCard(post: post);
          }),
    );
  }
}
