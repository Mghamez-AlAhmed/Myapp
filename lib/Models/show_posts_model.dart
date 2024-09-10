

class Post {
  int? id;
  String? title;
  String? body;
  Author? author;
  dynamic image;
  List<Tag>? tags;
  String? createdAt;
  int? commentsCount;
  List<Comment>? comments;

  Post({
    this.id,
    this.title,
    this.body,
    this.author,
    this.image,
    this.tags,
    this.createdAt,
    this.commentsCount,
    this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      author: json['author'] != null ? Author.fromJson(json['author']) : null,
      image: json['image'],
      tags: json['tags'] != null
          ? List<Tag>.from(json['tags'].map((x) => Tag.fromJson(x)))
          : null,
      createdAt: json['created_at'],
      commentsCount: json['comments_count'],
      comments: json['comments'] != null
          ? List<Comment>.from(json['comments'].map((x) => Comment.fromJson(x)))
          : null,
    );
  }
}

class Author {
  int? id;
 dynamic profileImage;
  int? isFake;
  String? username;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;

  Author({
    this.id,
    this.profileImage,
    this.isFake,
    this.username,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      profileImage: json['profile_image'],
      isFake: json['is_fake'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      rememberToken: json['remember_token'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Tag {
  String? name;
  String? arabicName;
  String? description;

  Tag({this.name, this.arabicName, this.description});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'],
      arabicName: json['arabic_name'],
      description: json['description'],
    );
  }
}

class Comment {
  int? id;
  String? body;
  Author? author;

  Comment({this.id, this.body, this.author});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      body: json['body'],
      author: json['author'] != null ? Author.fromJson(json['author']) : null,
    );
  }
}
