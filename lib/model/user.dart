class User {
  User({
    required this.id,
    required this.username,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String username;
  String image;
  String createdAt;
  String updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
