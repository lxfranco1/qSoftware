import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/models/Event.dart';
import 'package:place_picker/place_picker.dart';
import 'package:geocoder/geocoder.dart';
import 'submit_view.dart';

//
import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'dart:math';

const kGoogleApiKey = "AIzaSyAWYVZJQT8EI2zThvkQEUueB3K7-ZIkxF0";
//AIzaSyDl5dDD11nnBtfF4RvVdAy4Elpg2ciE8oQ
// to get places detail (lat/lng)
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);


class NewTripThirdView extends StatefulWidget {
  final Event event;
  const NewTripThirdView(this.event);

  @override
  NewTripThirdViewState createState() => NewTripThirdViewState();
}
final selfKey = GlobalKey<ScaffoldState>();

class NewTripThirdViewState extends State<NewTripThirdView> {
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      key: selfKey,
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
                child: RaisedButton(
                  onPressed: _handlePressButton,
                  child: Text("Pick A Location"),
                ),
              ),




              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: RaisedButton(
                  child: Text("Continue"),
                  onPressed: () {
                    if(widget.event.latitude == null || widget.event.longitude == null){
                      validateNotNull(selfKey.currentState, widget.event, "location");
                    }
                    else{
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NewTripSubmitView(event: widget.event))
                      );
                    }
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
  void onError(PlacesAutocompleteResponse response) {
    selfKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      language: "en",
      components: [Component(Component.country, "us")],
    );

    displayPrediction(p, selfKey.currentState, widget.event);
  }

}

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold, Event event) async {
  if (p != null) {
    // get detail (lat/lng)
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat.toDouble();
    final lng = detail.result.geometry.location.lng.toDouble();

    event.latitude = lat;
    event.longitude = lng;

    scaffold.showSnackBar(
      SnackBar(content: Text("Your Location was Saved! "
          "\n\n${p.description} "
          "\n\nHit Continue!")),
    );
  }
}


Future<Null> validateNotNull(ScaffoldState scaffold, Event event, String type) async{
  scaffold.showSnackBar(
    SnackBar(content: Text("Your $type can't be blank")),
  );
}









