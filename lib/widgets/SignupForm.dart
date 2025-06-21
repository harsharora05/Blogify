import 'package:blog/httpRequests/authentication.dart';
import 'package:blog/provider/authFormToggleProvider.dart';
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
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text("Name"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  obscureText: false,
                  controller: _nameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  autofocus: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Username";
                    } else if (value.length < 4) {
                      return "Minimum Length Should Be 4 Chars";
                    } else if (value.length > 25) {
                      return "Length Should Not Exceed 25 Chars";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text("Username"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  obscureText: false,
                  controller: _usernameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  autofocus: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text("Email"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  obscureText: false,
                  controller: _emailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  autofocus: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Password";
                    } else if (value.length < 8) {
                      return "Minimum Characters Should be 8";
                    } else if (!value.contains(RegExp(r'[A-Z]'))) {
                      return "should contain one capital letter";
                    } else if (!value.contains(RegExp(r'[0-9]'))) {
                      return "Should contain one numeric letter";
                    } else if (!value.contains(RegExp(r'[@#$%^&*]'))) {
                      return "should contain 1 special character";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text("Password"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  obscureText: true,
                  controller: _passwordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  autofocus: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Confirm Password";
                    } else if (value.length < 8) {
                      return "Minimum Characters Should be 8";
                    } else if (!value.contains(RegExp(r'[A-Z]'))) {
                      return "should contain one capital letter";
                    } else if (!value.contains(RegExp(r'[0-9]'))) {
                      return "Should contain one numeric letter";
                    } else if (!value.contains(RegExp(r'[@#$%^&*]'))) {
                      return "should contain 1 special character";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text("Confirm Password"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  obscureText: true,
                  controller: _confirmPasswordController,
                ),
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
