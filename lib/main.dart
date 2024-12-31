import 'package:blog/provider/authProvider.dart';
import 'package:blog/provider/postProvider.dart';
import 'package:blog/screens/Auth_screen.dart';
import 'package:blog/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authProvider = Authprovider();
  authProvider.initializeData();
  final rPostProvider = RecentPostProvider();
  rPostProvider.InitialRecentPosts();
  final pPostProvider = PopularPostProvider();
  pPostProvider.InitialPopularPosts();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => authProvider),
    ChangeNotifierProvider(create: (_) => rPostProvider),
    ChangeNotifierProvider(create: (_) => pPostProvider)
  ], child: const Myapp()));
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLogin = context.watch<Authprovider>().getIslogin() ?? false;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true).copyWith(
            primaryColor: const Color.fromARGB(255, 200, 186, 238),
            primaryColorDark: const Color.fromARGB(255, 90, 58, 177),
            primaryColorLight: const Color.fromARGB(255, 169, 160, 192)),
        home: isLogin ? const Homepage() : AuthScreen());
  }
}
