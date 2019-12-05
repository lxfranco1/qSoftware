class Event{
  String title;
  DateTime date;
  String description;
  String eventType;
  Map<String, double> location;

  Event(
      this.title,
      this.date,
      this.description,
      this.eventType,
      this.location
      );

  Map<String, dynamic> toJson() => {
    'title': title,
    'date': date,
    'description': description,
    'eventType': eventType,
    'location': location,
  };
}
