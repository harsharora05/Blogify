import 'package:blog/widgets/LoginForm.dart';
import 'package:blog/widgets/signupForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            isLogin
                ? LoginForm(formKey: _formKey)
                : SignupForm(formKey: _formKey),
            const SizedBox(
              height: 15,
            ),
            isLogin
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have account ?"),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = false;
                            });
                          },
                          child: const Text("SignUp Here!"))
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Existing User?"),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = true;
                            });
                          },
                          child: const Text("Login here!"))
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
