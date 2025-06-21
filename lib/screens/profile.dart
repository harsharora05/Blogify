import 'package:blog/httpRequests/authentication.dart';
import 'package:blog/provider/authProvider.dart';
import 'package:blog/screens/change_Password.dart';
import 'package:blog/screens/privacy_policy.dart';
import 'package:blog/widgets/ProfileTile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  "https://wallpapers.com/images/featured/cool-profile-picture-87h46gcobjl5e4xu.jpg"),
            ),
            const SizedBox(
              height: 5,
            ),
            Consumer(builder: (ctx, _, __) {
              return Text(
                ctx.watch<Authprovider>().username.toString(),
                style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 94, 94, 94), fontSize: 20),
              );
            }),
            const SizedBox(
              height: 5,
            ),
            Consumer(builder: (ctx, _, __) {
              return Text(
                ctx.watch<Authprovider>().email.toString(),
                style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 94, 94, 94), fontSize: 18),
              );
            }),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ChangePassword()));
              },
              child: const ProfileTile(
                icon: Icons.password,
                title: "Change Password",
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PrivacyPolicy()));
              },
              child: const ProfileTile(
                icon: Icons.lock,
                title: "Privacy Policy",
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                final res = logout();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Logout Successful")));
                context.read<Authprovider>().saveData(res);
                Navigator.of(context).pop();
              },
              child: const ProfileTile(
                icon: Icons.logout_rounded,
                title: "Logout",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
