import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/models/Event.dart';

import 'submit_view.dart';

class NewTripThirdView extends StatelessWidget {
  final Event event;
  NewTripThirdView({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: Text('Create Event - Location'),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                //TODO: Add Geolocation to the app
                //User Input Price -------------------------------------
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("Place Holder for Locatcation", style: TextStyle(fontSize: 20.0),),
                ),




                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: RaisedButton(
                    child: Text("Continue"),
                    onPressed: () {
                      //event.date = DateTime.now();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NewTripSubmitView(event: event))
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
    );
  }
}

