class Event{
  String title;
  DateTime date;
  double price;
  String description;
  String eventType;
  Map<String, double> location;

  Event(
      this.title,
      this.date,
      this.price,
      this.description,
      this.eventType,
      this.location
      );

  Map<String, dynamic> toJson() => {
    'title': title,
    'date': date,
    'price': price,
    'description': description,
    'eventType': eventType,
    'location': location,
  };
}
