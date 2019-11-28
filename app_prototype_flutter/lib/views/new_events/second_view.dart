import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/models/Event.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'third_view.dart';



class NewEventSecondView extends StatelessWidget{
  final Event event;
  NewEventSecondView({Key key, @required this.event}) : super(key: key);
  final format = DateFormat("MM/dd/yyyy HH:mm");



  //final _moneyFieldController = MoneyFieldController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text('Create Event - Date'),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
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






                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: RaisedButton(
                      child: Text("Continue"),
                      onPressed: () {
                        //event.date = DateTime.now();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => NewTripThirdView(event: event))
                        );
                      },
                    ),
                  ),


                ],
              ),
            )
        )
    );
  }
}