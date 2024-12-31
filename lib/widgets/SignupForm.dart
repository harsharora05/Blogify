import 'package:blog/httpRequests/authentication.dart';
import 'package:blog/provider/authProvider.dart';
import 'package:blog/widgets/formField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatelessWidget {
  SignupForm({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Sign Up",
          style:
              GoogleFonts.notoSans(fontSize: 38, fontWeight: FontWeight.w900),
        ),
        const SizedBox(
          height: 40,
        ),
        Form(
            key: _formKey,
            child: Column(children: [
              formFields(
                label: "Username",
                isObs: false,
                tcontroller: _usernameController,
              ),
              formFields(
                label: "Email",
                isObs: false,
                tcontroller: _emailController,
              ),
              formFields(
                label: "Password",
                isObs: true,
                tcontroller: _passwordController,
              ),
              formFields(
                label: "Confirm Password",
                isObs: true,
                tcontroller: _confirmPasswordController,
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final uname = _usernameController.text;
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      final confirmPassword = _confirmPasswordController.text;

                      final user =
                          await signUp(uname, email, password, confirmPassword);
                      print(user["isLoggedIn"]);
                      context.read<Authprovider>().saveData(user);

                      _confirmPasswordController.clear();
                      _emailController.clear();
                      _usernameController.clear();
                      _passwordController.clear();
                    }
                  },
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.notoSans(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  )),
            ])),
      ],
    );
  }
}
