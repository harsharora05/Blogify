import 'package:blog/httpRequests/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final oldPassController = TextEditingController();
    final newPassController = TextEditingController();
    final ConfirmNewPassController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        leading: BackButton(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Password";
                            }
                            return null;
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                            label: Text("Old Password"),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          obscureText: true,
                          controller: oldPassController),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter New Password";
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
                          autofocus: false,
                          decoration: InputDecoration(
                            label: Text("New Password"),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          obscureText: true,
                          controller: newPassController),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter New Password";
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
                          autofocus: false,
                          decoration: InputDecoration(
                            label: Text("Confirm New Password"),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          obscureText: true,
                          controller: ConfirmNewPassController),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                )),
            ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    var oldPassword = oldPassController.text;
                    var newPassword = newPassController.text;
                    var confirmNewPassword = ConfirmNewPassController.text;
                    Map<String, dynamic> response = await changePassword(
                        oldPassword, newPassword, confirmNewPassword);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(response["message"])));
                    if (response["status"] == 200) {
                      Navigator.of(context).pop();
                      oldPassController.clear();
                      newPassController.clear();
                      ConfirmNewPassController.clear();
                    }
                  }
                },
                child: Text(
                  "Change",
                  style: GoogleFonts.notoSans(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                )),
          ],
        ),
      ),
    );
  }
}
