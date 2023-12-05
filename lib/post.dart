class Post{
  final int userId;
  final String title;
  final String description;

  Post(this.userId, this.title, this.description);

  factory Post.fromJson(Map<String,dynamic> json) => Post(
    int.parse(json["userId"]),json["title"],json["body"]
  );



}