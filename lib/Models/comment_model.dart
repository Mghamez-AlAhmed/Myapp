class Commentmodel {
  final int? id;
  final String? body;
  final String ?Name;
  final String ?userName;
  final String ?email;

  final dynamic pofeliimage;

  final int ?updated_at;
  final String? createdat;

  Commentmodel({
   this.email,
    this.id,
     this.body,
    this.Name,
     this.userName,
    this.pofeliimage,
     this.updated_at,
     this.createdat,
  });

  factory Commentmodel.fromJson(Map<String, dynamic> json) {
    return Commentmodel(
        id: json['id'],
        body: json['body'],
        email: json['author']['name'],
        Name: json['author']['name'],
        userName: json["author"]["username"],
        pofeliimage: json["author"]["profile_image"] ?? "",
        updated_at: json["author"]['comments_count'],
        createdat: json["author"]["created_at"]);
  }

}
