import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/models/Event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewEventPriceView extends StatelessWidget{
  final db = Firestore.instance;

  final Event event;
  NewEventPriceView({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event - Price'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text("Finished", style: TextStyle(fontSize: 20.0),),
            ),
            Text("Title ${event.title}"),
            Text("Date ${event.date}"),

            RaisedButton(
              child: Text("Finished"),
              // Save Data to Firebase
              onPressed: () async {
                // SAVEING DATA
                await db.collection("events").add(
                  event.toJson()
                  /*
                  {
                    'title': event.title,
                    'date': event.date,
                    'price': event.price,
                    'description': event.description,
                    'eventType': event.eventType,
                    'location': event.location,
                  }
                   */

                );

                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            )
          ],
        )
      )
    );
  }
}