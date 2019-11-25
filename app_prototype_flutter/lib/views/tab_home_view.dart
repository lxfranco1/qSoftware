import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/Event.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {

  final List<Event> eventList= [
    Event("Homecoming", DateTime.now(), 200.00, "This is a test party", "Club", {"52.2165157": 6.9437819}),
    Event("Prom", DateTime.now(), 167.00, "This is a test party", "Club", {"52.2165157": 6.9437819}),
    Event("Theta Tau Tailgate", DateTime.now(), 0.00, "This is a test party", "Club", {"52.2165157": 6.9437819}),
    Event("NSBE Bonefire", DateTime.now(), 369.00, "This is a test party", "Club", {"52.2165157": 6.9437819}),
    Event("Project X", DateTime.now(), 24489.00, "This is a test party", "Club", {"52.2165157": 6.9437819}),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
        itemCount: eventList.length,
        itemBuilder: (BuildContext context, int index) => buildEventCard(context, index)
      ),
    );
  }

  //Widget for the Cards
  Widget buildEventCard(BuildContext context, int index){
    final event = eventList[index];
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  Text(event.title, style: new TextStyle(fontSize: 30.0)),
                  Spacer(),
                ],),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  Text("${DateFormat('MM/dd/yyyy').format(event.date).toString()} at ${DateFormat('jm').format(event.date).toString()}"),
                  Spacer(),
                ],),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  Text(event.description),
                  Spacer(),
                  Text("\$${event.price.toStringAsFixed(2)}", style: new TextStyle(fontSize: 20.0)),
                ],),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  Text(event.eventType),
                  Spacer(),
                  Icon(Icons.location_on),
                  //Text(event.location.toString()),
                ],),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
