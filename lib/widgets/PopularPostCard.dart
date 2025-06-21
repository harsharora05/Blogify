import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/favourite_post_provider.dart';

class PopularPostCard extends StatelessWidget {
  const PopularPostCard({
    super.key,
    required this.post,
  });

  final dynamic post;

  @override
  Widget build(BuildContext context) {
    return Consumer<Favouritepostprovider>(
        builder: (ctx, Favouritepostprovider, child) {
      bool isFavorite = Favouritepostprovider.isPostFavorited(post.id);
      return Card(
          elevation: 4,
          child: Column(
            children: [
              Container(
                height: 210 / 1.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(post.photo),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6, top: 5),
                      child: Text(
                        post.username,
                        style: GoogleFonts.acme(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, right: 5),
                    child: InkWell(
                      onTap: () async {
                        bool operation =
                            await Favouritepostprovider.toggleFavPosts(post);
                        print(operation);
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
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  post.title,
                  style: GoogleFonts.acme(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              )
            ],
          ));
    });
  }
}
