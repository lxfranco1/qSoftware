class Event{
  String title;
  DateTime date;
  String description;
  String eventType;
  int attendance = 0;
  double rating = 0.0;
  List<String> followers = [];
  List<String> following = [];
  String creatorsID;
  double latitude;
  double longitude;
  String username;

  Event(
      this.title,
      this.date,
      this.description,
      this.eventType,
      this.attendance,
      this.rating,
      this.followers,
      this.following,
      this.creatorsID,
      this.username,
      this.latitude,
      this.longitude,
      );

  Map<String, dynamic> toJson() => {
    'title': title,
    'date': date,
    'description': description,
    'eventType': eventType,
    'attendance': attendance,
    'rating': rating,
    'followers': followers,
    'following': following,
    'creatorsID': creatorsID,
    'latitude': latitude,
    'longitude': longitude,
  };
}
