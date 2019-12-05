class Event{
  String title;
  DateTime date;
  String description;
  String eventType;
  Map<String, double> location;
  int attendance = 0;
  List<String> followers = [];
  List<String> following = [];
  String creatorsID;

  Event(
      this.title,
      this.date,
      this.description,
      this.eventType,
      this.location,
      this.attendance,
      this.followers,
      this.following,
      this.creatorsID,
      );

  Map<String, dynamic> toJson() => {
    'title': title,
    'date': date,
    'description': description,
    'eventType': eventType,
    'location': location,
    'attendance': attendance,
    'followers': followers,
    'following': following,
    'creatorsID': creatorsID,
  };
}
