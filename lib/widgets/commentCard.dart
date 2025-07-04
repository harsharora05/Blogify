import 'package:blog/model/commentsModel.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class commentCard extends StatelessWidget {
  const commentCard({super.key, required this.comment, required this.isReply});
  final Comment comment;
  final bool isReply;
  String getTimeAgo(String isoString) {
    final dateTime =
        DateTime.parse(isoString).toLocal(); // convert to local time
    return timeago.format(dateTime); // e.g., "15 hours ago"
  }

  Widget build(BuildContext context) {
    var time = getTimeAgo(comment.postedAt);
    displayReplySheet() {
      showModalBottomSheet(
          enableDrag: false,
          isScrollControlled: true,
          useSafeArea: true,
          context: context,
          builder: (BuildContext context) {
            return Container(
                width: double.infinity,
                color: Colors.grey.shade100,
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
                              "Replies",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                            controller: ScrollController(),
                            shrinkWrap: true,
                            itemCount: comment.replies.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: commentCard(
                                    comment: comment.replies[index],
                                    isReply: true),
                              );
                            }),
                      )
                    ]));
          });
    }

    return Card(
      child: Container(
        padding: EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  comment.username,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "\u2022 ${time}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              comment.content,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            !isReply
                ? Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.reply)),
                      SizedBox(
                        width: 5,
                      ),
                      comment.replies.isNotEmpty
                          ? TextButton(
                              onPressed: () {
                                displayReplySheet();
                              },
                              child: Text(
                                "${comment.replies.length} replies...",
                                style: TextStyle(fontSize: 15),
                              ))
                          : SizedBox()
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
