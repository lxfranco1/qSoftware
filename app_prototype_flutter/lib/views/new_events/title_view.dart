import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/models/Event.dart';
import 'date_view.dart';

class NewTripTitleView extends StatelessWidget{
  final Event event;
  NewTripTitleView({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleControler = new TextEditingController();
    _titleControler.text = event.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event - Title'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text("Enter a Title", style: TextStyle(fontSize: 20.0),),
              ),

              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _titleControler,
                  autofocus: true,
                ),
              ),

              RaisedButton(
                child: Text("Continue"),
                onPressed: () {
                  event.title = _titleControler.text;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewEventDateView(event: event))
                  );
                },
              )
            ],
          )
      )
    );
  }
}