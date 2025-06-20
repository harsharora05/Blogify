import 'package:blog/httpRequests/authentication.dart';
import 'package:blog/provider/authProvider.dart';
import 'package:blog/widgets/formField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Login",
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
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final email = _emailController.text;
                      final password = _passwordController.text;

                      Map<String, dynamic> user = await login(email, password);
                      if (user["status"] == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(user["message"])));
                        context.read<Authprovider>().saveData(user);
                        _emailController.clear();
                        _passwordController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(user["message"])));
                      }
                    }
                  },
                  child: Text(
                    "Login",
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
