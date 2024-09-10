class UsersModel {
  final String? username;
  final String ?name;
  final String ?email;
  final int ?id;
  final dynamic profileImage;
  final int ?commentsCount;
  final int ?postsCount;

  UsersModel({
 this.username,
    this.name,
   this.email,
   this.id,
    this.profileImage,
    this.commentsCount,
 this.postsCount,
  });

  // Factory method to create a UserModel from JSON
  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      username: json['username'],
      
      name: json['name'],
      email: json['email'],
      id: json['id'],
      profileImage: json['profile_image'],
      commentsCount: json['comments_count'],
      postsCount: json['posts_count'],
     
    );
  }
}
