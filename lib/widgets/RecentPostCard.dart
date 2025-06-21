import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/favourite_post_provider.dart';

class RecentPostCard extends StatelessWidget {
  const RecentPostCard({
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
        child: SizedBox(
          height: 100,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: 100,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: NetworkImage(post.photo), fit: BoxFit.cover)),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              post.category,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.acme(
                                  color:
                                      const Color.fromARGB(255, 104, 103, 103),
                                  fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: () async {
                                  bool operation = await Favouritepostprovider
                                      .toggleFavPosts(post);
                                  if (operation) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Post added to favorites Successfully")));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Post removed from favorites Successfully")));
                                  }
                                },
                                child: isFavorite
                                    ? Icon(Icons.favorite, color: Colors.red)
                                    : Icon(Icons.favorite_border)),
                          ),
                        ],
                      ),
                      Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 12.0),
                              width: 170,
                              child: Text(
                                softWrap: true,
                                post.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.acme(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 12.0),
                              width: 120,
                              child: Text(
                                softWrap: true,
                                post.username,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.acme(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            )
                          ],
                        )
                      ]),
                    ],
                  ))
            ],
          ),
        ),
      );
    });
  }
}
