import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/models/Event.dart';
import 'package:place_picker/place_picker.dart';
import 'package:geocoder/geocoder.dart';
import 'submit_view.dart';



class NewTripThirdView extends StatefulWidget {
  final Event event;
  const NewTripThirdView(this.event);

  @override
  NewTripThirdViewState createState() => NewTripThirdViewState();
}

class NewTripThirdViewState extends State<NewTripThirdView> {
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
                child: Center(
                  child: Text("Place Holder for Location", style: TextStyle(fontSize: 20.0),),
                ) ,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
              ),




              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: RaisedButton(
                  child: Text("Continue"),
                  onPressed: () {
                    //event.date = DateTime.now();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewTripSubmitView(event: widget.event))
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












