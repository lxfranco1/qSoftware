class Event{
  String title;
  DateTime date;
  String description;
  String eventType;
  Map<String, double> location;
  int attendance = 0;
  double rating = 0.0;
  List<String> followers = [];
  List<String> following = [];
  String creatorsID;
  String username;

  Event(
      this.title,
      this.date,
      this.description,
      this.eventType,
      this.location,
      this.attendance,
      this.rating,
      this.followers,
      this.following,
      this.creatorsID,
      this.username,
      );

  Map<String, dynamic> toJson() => {
    'title': title,
    'date': date,
    'description': description,
    'eventType': eventType,
    'location': location,
    'attendance': attendance,
    'rating': rating,
    'followers': followers,
    'following': following,
    'creatorsID': creatorsID,
    'username': username,
  };
}
