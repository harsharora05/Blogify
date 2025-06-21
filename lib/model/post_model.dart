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

class FavPost {
  String id;
  String content;
  String photo;
  String title;
  String username;
  String category;
  int likes;
  FavPost(
      {required this.content,
      required this.photo,
      required this.title,
      required this.username,
      required this.category,
      required this.likes,
      required this.id});

  // Factory method to create a Post object from JSON
  factory FavPost.fromJson(Map<dynamic, dynamic> json) {
    final likedBy = json['likedBy'] as Map<String, dynamic>;
    return FavPost(
        content: json['post']['content'] as String,
        photo: json['post']['image'] as String,
        title: json['post']['title'] as String,
        username: likedBy['username'] as String,
        category: json['post']['category'] as String,
        likes: json['post']['likes'] as int,
        id: json['post']['_id'] as String);
  }
}
