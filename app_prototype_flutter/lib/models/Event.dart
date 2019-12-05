class Event{
  String title;
  DateTime date;
  String description;
  String eventType;
  Map<String, double> location;
  List followers = [];
  List following = [];
  String creatorsID;

  Event(
      this.title,
      this.date,
      this.description,
      this.eventType,
      this.location,
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
    'followers': followers,
    'following': following,
    'creatorsID': creatorsID,
  };
}
