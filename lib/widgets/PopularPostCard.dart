import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/post_model.dart';

class PopularPostCard extends StatelessWidget {
  const PopularPostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
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
              const Padding(
                padding: EdgeInsets.only(top: 5, right: 5),
                child: Icon(Icons.favorite_border),
              )
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
      ),
    );
  }
}
