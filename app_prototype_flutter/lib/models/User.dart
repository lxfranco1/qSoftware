  class User{
  String name;
  String userName;
  String email;
  List<String> followers = [];
  List<String> following = [];
  String uid;

  User(
      this.name,
      this.userName,
      this.email,
      this.followers,
      this.following,
      this.uid,
      );

  Map<String, dynamic> toJson() => {
    'firstName': name,
    'userName': userName,
    'email': email,
    'followers': followers,
    'following': following,
    'uid': uid,
  };

}