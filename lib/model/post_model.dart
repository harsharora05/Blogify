class Post {
  String id;
  String content;
  String photo;
  String title;
  String username;
  String category;
  int likes;
  Post(
      {required this.content,
      required this.photo,
      required this.title,
      required this.username,
      required this.category,
      required this.likes,
      required this.id});

  // Factory method to create a Post object from JSON
  factory Post.fromJson(Map<dynamic, dynamic> json) {
    final by = json['by'] as Map<String, dynamic>;
    return Post(
        content: json['content'] as String,
        photo: json['image'] as String,
        title: json['title'] as String,
        username: by['username'] as String,
        category: json['category'] as String,
        likes: json['likes'] as int,
        id: json['_id'] as String);
  }
}
