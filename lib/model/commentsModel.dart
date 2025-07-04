class Comment {
  String id;
  String username;
  String content;
  String postedAt;
  List<Comment> replies;

  Comment(
      {required this.id,
      required this.username,
      required this.content,
      required this.postedAt,
      required this.replies});

  factory Comment.fromJson(Map<String, dynamic> json) {
    final by = json['by'] as Map<String, dynamic>;
    return Comment(
      id: json['_id'] as String,
      username: by['username'] as String,
      content: json['content'] as String,
      postedAt: json['createdAt'] as String,
      replies: (json['reply'] as List<dynamic>?)
              ?.map((reply) => Comment.fromJson(reply as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
