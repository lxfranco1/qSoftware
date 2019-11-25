import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/models/Event.dart';
import 'price_view.dart';

class NewEventDateView extends StatelessWidget{
  final Event event;
  NewEventDateView({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Create Event - Date'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text("Enter a Date", style: TextStyle(fontSize: 20.0),),
                ),


                RaisedButton(
                  child: Text("Continue"),
                  onPressed: () {
                    event.date = DateTime.now();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewEventPriceView(event: event))
                    );
                  },
                )
              ],
            )
        )
    );
  }
}