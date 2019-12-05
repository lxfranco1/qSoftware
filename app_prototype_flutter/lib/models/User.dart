class User{
  String firstName;
  String lastName;
  String userName;
  String email;
  List followers = [];
  List following = [];

  User(
      this.firstName,
      this.lastName,
      this.userName,
      this.email,
      this.followers,
      this.following,
      );

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'userName': userName,
    'email': email,
    'followers': followers,
    'following': following,
  };

}