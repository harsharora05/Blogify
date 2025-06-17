import 'package:blog/provider/postProvider.dart';
import 'package:blog/widgets/dropDown.dart';
import 'package:blog/widgets/ImagePick.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:super_bullet_list/bullet_list.dart';

class Addpost extends StatefulWidget {
  const Addpost({super.key});

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  final titleController = TextEditingController();
  String category = "";
  late String title;
  late String content;
  late XFile image;
  final contentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void getCategory(String value) {
    setState(() {
      category = value;
    });
  }

  void getImage(XFile img) {
    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      "Sports",
      "Business",
      "Entertainment",
      "Life",
      "Food",
      "Others"
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
            child: TextButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    title = titleController.text;
                    content = contentController.text;
                    Map<String, dynamic> res = await context
                        .read<RecentPostProvider>()
                        .AddPost(title, content, category, image);
                    if (res["status"] == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(res["message"])));
                      titleController.clear();
                      contentController.clear();
                      Navigator.of(context).pop();
                    } else if (res["status"] == 400) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(res["message"])));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Post Upload Failed!!! Try Again...")));
                    }
                  }
                },
                child: const Text("Publish")),
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
                    pickImage(getImage: getImage),
                    const SizedBox(
                      height: 17,
                    ),
                    Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: titleController,
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
                            dropDown(
                                categories: categories,
                                getCategory: getCategory),
                            const SizedBox(
                              height: 17,
                            ),
                            TextFormField(
                              controller: contentController,
                              maxLines: 12,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text("Content")),
                              keyboardType: TextInputType.multiline,
                              maxLength: 3500,
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const SuperBulletList(iconColor: Colors.black, items: [
                      Text("Press Enter 2 times to start a new Paragraph."),
                      Text("Insert a landscape image (Recommended)")
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
