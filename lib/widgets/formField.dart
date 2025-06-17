import 'package:flutter/material.dart';

class formFields extends StatelessWidget {
  const formFields(
      {super.key,
      required this.autoFocus,
      required this.label,
      required this.isObs,
      required this.tcontroller});

  final bool autoFocus;
  final String label;
  final bool isObs;
  final TextEditingController tcontroller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
          autofocus: true,
          controller: tcontroller,
          obscureText: isObs,
          decoration: InputDecoration(
            label: Text(label),
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 2),
                borderRadius: BorderRadius.all(Radius.circular(20))),
          )),
    );
  }
}
