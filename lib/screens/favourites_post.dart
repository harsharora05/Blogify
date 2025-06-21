import "package:blog/model/post_model.dart";
import "package:blog/provider/favourite_post_provider.dart";
import "package:blog/screens/display_post.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class FavouritePost extends StatelessWidget {
  const FavouritePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favourites"),
        ),
        body: Consumer<Favouritepostprovider>(
            builder: (context, Favouritepostprovider, child) {
          List<FavPost> fPosts = Favouritepostprovider.favPosts;
          if (fPosts.isEmpty) {
            return Center(
              child: Text("No Favourite Posts"),
            );
          }
          return ListView.builder(
              itemCount: fPosts.length,
              itemBuilder: (context, index) {
                final post = fPosts[index];
                bool isFavorite =
                    Favouritepostprovider.isPostFavorited(post.id);
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Displaypost(
                        post: post,
                      );
                    }));
                  },
                  child: Card(
                    child: ListTile(
                      trailing: InkWell(
                          onTap: () async {
                            bool operation =
                                await Favouritepostprovider.toggleFavPosts(
                                    post);
                            if (operation) {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Post added to favorites Successfully")));
                            } else {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Post removed from favorites Successfully")));
                            }
                          },
                          child: isFavorite
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(Icons.favorite_border_outlined)),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(post.photo),
                      ),
                      title: Text(
                        post.title,
                        maxLines: 1,
                      ),
                      subtitle: Text(post.username),
                    ),
                  ),
                );
              });
        }));
  }
}
