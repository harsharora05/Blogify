import 'package:blog/provider/authProvider.dart';
import 'package:blog/screens/add_post.dart';
import 'package:blog/screens/favourites_post.dart';
import 'package:blog/screens/profile.dart';
import 'package:blog/widgets/drawerCards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://wallpapers.com/images/featured/cool-profile-picture-87h46gcobjl5e4xu.jpg"),
                ),
                Consumer(builder: (ctx, _, __) {
                  return Text(
                    ctx.watch<Authprovider>().username.toString(),
                    style: const TextStyle(
                        fontFamily: AutofillHints.username,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  height: 1,
                  color: Colors.black,
                )
              ],
            ),
          ),
          const drawerWidget(
            ic: Icons.person_outlined,
            title: "Profile",
            screen: Profile(),
          ),
          const SizedBox(
            height: 5,
          ),
          const drawerWidget(
            ic: Icons.favorite_border,
            title: "Favourites",
            screen: FavouritePost(),
          ),
          const SizedBox(
            height: 5,
          ),
          const drawerWidget(
            ic: Icons.edit,
            title: "Write a Story",
            screen: Addpost(),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
