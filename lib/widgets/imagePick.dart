import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class pickImage extends StatefulWidget {
  const pickImage({
    super.key,
  });

  @override
  State<pickImage> createState() => _pickImageState();
}

class _pickImageState extends State<pickImage> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  XFile? pickedimg;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pickedimg != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        File(pickedimg!.path),
                        fit: BoxFit.cover,
                        height: 248,
                        width: double.infinity,
                      ),
                    )
                  : const Text("Choose Photo"),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
              onPressed: () async {
                image = await _picker.pickImage(source: ImageSource.camera);
                setState(() {
                  pickedimg = image;
                });
              },
              child: const Text("Camera")),
          const SizedBox(
            width: 20,
          ),
          OutlinedButton(
              onPressed: () async {
                image = await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  pickedimg = image;
                });
              },
              child: const Text("Gallery"))
        ],
      ),
    ]);
  }
}
