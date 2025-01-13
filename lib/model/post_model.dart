class Post {
  int id;
  String content;
  String photo;
  String title;
  String username;
  String category;
  bool isFav;
  int likes;
  Post(
      {required this.content,
      required this.photo,
      required this.title,
      required this.username,
      required this.category,
      required this.likes,
      required this.isFav,
      required this.id});

  // Factory method to create a Post object from JSON
  factory Post.fromJson(Map<dynamic, dynamic> json) {
    return Post(
        content: json['content'],
        photo: json['img'], // Adjusted to match the key in JSON
        title: json['title'],
        username: json['user'],
        category: json['category'],
        likes: json['likes'],
        isFav: false,
        id: json['id']);
  }
}
