class Event{
  final String title;
  final DateTime date;
  final double price;
  final String description;
  final String eventType;
  final Map<String, double> location;

  Event(this.title, this.date, this.price, this.description, this.eventType, this.location);
}