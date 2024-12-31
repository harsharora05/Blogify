import 'package:blog/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Displaypost extends StatelessWidget {
  const Displaypost({super.key, required this.post});

  final Post post;

  void displayCommentsSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 2300,
            width: double.infinity,
            color: Colors.amber,
            child: Column(
              children: [
                OutlinedButton(onPressed: () {}, child: const Text("hello"))
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String content = post.content;
    List<String> paragraphs = content.split("\n\n");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                post.title,
                style: GoogleFonts.daiBannaSil(
                    fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                        image: NetworkImage(post.photo), fit: BoxFit.cover)),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    post.category,
                    style: GoogleFonts.lato(
                        color: const Color.fromARGB(255, 188, 187, 187),
                        fontSize: 15),
                  ),
                  Text(
                    "1 min ago",
                    style: GoogleFonts.lato(
                        color: const Color.fromARGB(255, 188, 187, 187),
                        fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.thumb_up_alt_outlined)),
                  IconButton(
                      onPressed: () {
                        displayCommentsSheet(context);
                      },
                      icon: const Icon(Icons.comment_outlined)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ...paragraphs.map((paragraph) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    paragraph.trim(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      height: 1.5,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
