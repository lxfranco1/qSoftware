import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/models/Event.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'third_view.dart';


class NewEventSecondView extends StatefulWidget {
  final Event event;
  const NewEventSecondView(this.event);

  @override
  NewEventSecondViewState createState() => NewEventSecondViewState();
}

final selfKey = GlobalKey<ScaffoldState>();


class NewEventSecondViewState extends State<NewEventSecondView> {

  final format = DateFormat("MM/dd/yyyy HH:mm");



  //final _moneyFieldController = MoneyFieldController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: selfKey,
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
                          widget.event.date = DateTimeField.combine(date, time);
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
                        if(widget.event.date == null){
                          validateNotNull(selfKey.currentState, widget.event, "date");
                        }
                        else{
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => NewTripThirdView(widget.event))
                          );
                        }
                        //event.date = DateTime.now();

                      },
                    ),
                  ),


                ],
              ),
            )
        )
    );
  }
  Future<Null> validateNotNull(ScaffoldState scaffold, Event event, String type) async{
    scaffold.showSnackBar(
      SnackBar(content: Text("Your $type can't be blank")),
    );
  }
}