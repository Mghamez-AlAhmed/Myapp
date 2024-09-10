// models/post_model.dart
class Postvi {
  final int id;
  final String? title;
  final String body;
  final String authorName;
  final String userName;

  final dynamic image;
  final dynamic pofeliimage;

  final int commentsCount;
  final String createdat;

  Postvi({
    required this.id,
    this.title,
    required this.body,
    required this.authorName,
    required this.userName,

    this.image,
    this.pofeliimage,

    required this.commentsCount,
    required this.createdat,

  });

  factory Postvi.fromJson(Map<String, dynamic> json) {
    return Postvi(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      authorName: json['author']['name'],
      userName: json["author"]["username"],
      pofeliimage: json["author"]["profile_image"]??"",
      image: json['image'] ?? '',
      commentsCount: json['comments_count'],
      createdat:json["created_at"]
    );
  }
}
