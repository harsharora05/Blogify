import 'package:blog/provider/authFormToggleProvider.dart';
import 'package:blog/widgets/LoginForm.dart';
import 'package:blog/widgets/signupForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Provider.of<AuthFormToggleProvider>(context, listen: true)
                        .isLoginForm
                    ? SingleChildScrollView(child: LoginForm(formKey: _formKey))
                    : SingleChildScrollView(
                        child: SignupForm(formKey: _formKey)),
                const SizedBox(
                  height: 15,
                ),
                Provider.of<AuthFormToggleProvider>(context, listen: true)
                        .isLoginForm
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have account ?"),
                          TextButton(
                              onPressed: () {
                                Provider.of<AuthFormToggleProvider>(context,
                                        listen: false)
                                    .toggleForm();
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
                                Provider.of<AuthFormToggleProvider>(context,
                                        listen: false)
                                    .toggleForm();
                              },
                              child: const Text("Login here!"))
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
