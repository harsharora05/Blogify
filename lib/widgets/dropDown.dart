import 'package:flutter/material.dart';

class dropDown extends StatefulWidget {
  const dropDown({
    super.key,
    required this.categories,
    required this.getCategory,
  });

  final List<String> categories;
  final Function(String value) getCategory;

  @override
  State<dropDown> createState() => _dropDownState();
}

class _dropDownState extends State<dropDown> {
  String? choosenCategory;
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      child: DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return "Please Select a Category";
          }
          return null;
        },
        value: choosenCategory,
        hint: const Text("Select a Category"),
        items: widget.categories.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            choosenCategory = value;
            widget.getCategory(value!);
          });
        },
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
