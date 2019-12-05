class User{
  String name;
  String userName;
  String email;
  List<String> followers = [];
  List<String> following = [];

  User(
      this.name,
      this.userName,
      this.email,
      this.followers,
      this.following,
      );

  Map<String, dynamic> toJson() => {
    'firstName': name,
    'userName': userName,
    'email': email,
    'followers': followers,
    'following': following,
  };

}