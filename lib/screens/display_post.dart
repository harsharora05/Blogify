import 'package:blog/widgets/commentCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:blog/provider/commentsProvider.dart';

class Displaypost extends StatelessWidget {
  const Displaypost({super.key, required this.post});
  final dynamic post;

  String getTimeAgo(String isoString) {
    final dateTime =
        DateTime.parse(isoString).toLocal(); // convert to local time
    return timeago.format(dateTime); // e.g., "15 hours ago"
  }

  void displayCommentsSheet(BuildContext outerContext) {
    var commentController = TextEditingController();
    var _formKey = GlobalKey<FormState>();
    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        useSafeArea: true,
        context: outerContext,
        builder: (context) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.arrow_back)),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          "Comments",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: commentController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Comment";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Write Comment",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          suffixIcon: Container(
                            margin: EdgeInsets.all(8),
                            child: ElevatedButton.icon(
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.black,
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100, 50),
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                label: Text(
                                  "Comment",
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    var content = commentController.text;
                                    var postId = post.id;

                                    Map<String, dynamic> response =
                                        await context
                                            .read<CommentsProvider>()
                                            .commentAddP(content, postId);
                                    ScaffoldMessenger.of(outerContext)
                                        .showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              response["message"].toString())),
                                    );

                                    if (response["statusCode"] == 200) {
                                      commentController.clear();
                                    }
                                  }
                                }),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Consumer<CommentsProvider>(
                            builder: (ctx, CommentsProvider, child) {
                          if (CommentsProvider.isLoading) {
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 600,
                                      width: double.infinity,
                                      child: Center(
                                          child: CircularProgressIndicator()))
                                ],
                              ),
                            );
                          } else if (CommentsProvider.comments.isEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 600,
                                    width: double.infinity,
                                    child: Center(child: Text("No Comments")))
                              ],
                            );
                          } else {
                            return Expanded(
                              child: ListView.builder(
                                  controller: ScrollController(),
                                  shrinkWrap: true,
                                  itemCount: CommentsProvider.comments.length,
                                  itemBuilder: (context, index) {
                                    return commentCard(
                                      isReply: false,
                                      comment: CommentsProvider.comments[index],
                                    );
                                  }),
                            );
                          }
                        })),
                  )
                ],
              ),
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
                    getTimeAgo(post.createdAt),
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
                        Provider.of<CommentsProvider>(context, listen: false)
                            .getComments(post.id);
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
