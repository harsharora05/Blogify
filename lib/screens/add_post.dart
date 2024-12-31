import 'package:blog/widgets/dropDown.dart';
import 'package:blog/widgets/ImagePick.dart';
import 'package:flutter/material.dart';
import 'package:super_bullet_list/bullet_list.dart';

class Addpost extends StatefulWidget {
  const Addpost({super.key});

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      "Sports",
      "Business",
      "Entertainment",
      "Life",
      "Food"
    ];
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back_ios)),
        title: const Text("Write Your Story"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: TextButton(onPressed: () {}, child: const Text("Publish")),
          )
        ],
      ),
      body: Center(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const pickImage(),
                    const SizedBox(
                      height: 17,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        label: Text("Title"),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    dropDown(categories: categories),
                    const SizedBox(
                      height: 17,
                    ),
                    const TextField(
                      maxLines: 12,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), label: Text("Content")),
                      keyboardType: TextInputType.multiline,
                      maxLength: 3500,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SuperBulletList(iconColor: Colors.black, items: [
                      Text("Press Enter 2 times to start a new Paragraph.")
                    ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
