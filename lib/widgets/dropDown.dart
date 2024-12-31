import 'package:flutter/material.dart';

class dropDown extends StatefulWidget {
  const dropDown({
    super.key,
    required this.categories,
  });

  final List<String> categories;

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
      child: DropdownButton(
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
          });
        },
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
