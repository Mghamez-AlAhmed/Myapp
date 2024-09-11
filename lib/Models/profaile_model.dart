class UserModel {
  final String? username;
  final String ?name;
  final String ?email;
  final int ?id;
  final dynamic profileImage;
  final int ?commentsCount;
  final int ?postsCount;
  final String ?token;

  UserModel({
 this.username,
    this.name,
   this.email,
   this.id,
    this.profileImage,
    this.commentsCount,
 this.postsCount,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['user']['username'],
      name: json['user']['name'],
      email: json['user']['email'],
      id: json['user']['id'],
      profileImage: json['user']['profile_image'],
      commentsCount: json['user']['comments_count'],
      postsCount: json['user']['posts_count'],
      token: json['token'],
    );
  }
}
