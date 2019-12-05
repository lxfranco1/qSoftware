class User{
  String firstName;
  String lastName;
  String userName;
  String email;
  int attendance = 0;
  List followers = [];
  List following = [];

  User(
      this.firstName,
      this.lastName,
      this.userName,
      this.email,
      this.attendance,
      this.followers,
      this.following,
      );

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'userName': userName,
    'email': email,
    'attendance': attendance,
    'followers': followers,
    'following': following,
  };

}