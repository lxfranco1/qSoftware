import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/models/Event.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class NewEventSecondView extends StatelessWidget{
  final Event event;
  NewEventSecondView({Key key, @required this.event}) : super(key: key);
  final format = DateFormat("MM/dd/yyyy HH:mm");
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {

    TextEditingController _priceControler = new TextEditingController();
    _priceControler.text = event.price.toString();

    return Scaffold(
        appBar: AppBar(
          title: Text('Create Event - Date'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                //User Input Date and Time -------------------------------------
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("Date and Time", style: TextStyle(fontSize: 20.0),),
                ),

                //Text('Basic date & time field (${format.pattern})'),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: DateTimeField(
                    format: format,
                    decoration: new InputDecoration(
                        hintText: "Click to input date"
                    ),
                    textInputAction: TextInputAction.none,
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2019),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2021));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime:
                          TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                        );
                        event.date = DateTimeField.combine(date, time);
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                  ),
                ),


                //User Input Price -------------------------------------
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("Price", style: TextStyle(fontSize: 20.0),),
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: new TextFormField(
                    controller: _priceControler,
                    //autofocus: true,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.done,
                    decoration: new InputDecoration(
                        hintText: "Enter event price"
                    ),

                  ),
                ),




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