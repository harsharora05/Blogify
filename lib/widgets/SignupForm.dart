import 'package:blog/httpRequests/authentication.dart';
import 'package:blog/provider/authFormToggleProvider.dart';
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
  final _nameController = TextEditingController();
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
                autoFocus: true,
                label: "Name",
                isObs: false,
                tcontroller: _nameController,
              ),
              formFields(
                autoFocus: false,
                label: "Username",
                isObs: false,
                tcontroller: _usernameController,
              ),
              formFields(
                autoFocus: false,
                label: "Email",
                isObs: false,
                tcontroller: _emailController,
              ),
              formFields(
                autoFocus: false,
                label: "Password",
                isObs: true,
                tcontroller: _passwordController,
              ),
              formFields(
                autoFocus: false,
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
                      final name = _nameController.text;
                      final uname = _usernameController.text;
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      final confirmPassword = _confirmPasswordController.text;

                      Map<String, dynamic> response = await signUp(
                          name, uname, email, password, confirmPassword);

                      if (response["status"] == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(response["message"])));
                        Provider.of<AuthFormToggleProvider>(context,
                                listen: false)
                            .toggleForm();

                        _nameController.clear();
                        _confirmPasswordController.clear();
                        _emailController.clear();
                        _usernameController.clear();
                        _passwordController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(response["message"])));
                      }
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
