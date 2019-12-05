import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/models/Event.dart';
import 'second_view.dart';


class NewEvent extends StatefulWidget {
  final Event event;
  const NewEvent(this.event);

  @override
  NewEventState createState() => NewEventState();
}

final selfKey = GlobalKey<ScaffoldState>();


class NewEventState extends State<NewEvent> {

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleControler = new TextEditingController();
    _titleControler.text = widget.event.title;


    final TextEditingController _descriptionControler = new TextEditingController();
    _descriptionControler.text = widget.event.description;




    return Scaffold(
      key: selfKey,
      appBar: AppBar(
        title: Text('Create  - Title'),
      ),
      body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  //User Input Title --------------------------------------------
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Text("Title", style: TextStyle(fontSize: 20.0),),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: new TextFormField(
                      controller: _titleControler,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.none,
                      decoration: new InputDecoration(
                          hintText: "Enter the event title"
                      ),
                    ),
                  ),

                  //User Input Description --------------------------------------
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text("Description", style: TextStyle(fontSize: 20.0),),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: new TextFormField(
                      controller: _descriptionControler,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textInputAction: TextInputAction.none,
                      decoration: new InputDecoration(
                          hintText: "Enter the event description"
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: RaisedButton(
                      child: Text("Continue"),
                      onPressed: () {
                        widget.event.title = _titleControler.text;
                        widget.event.description = _descriptionControler.text;
                        //event.date = DateTime.now();
                        if(widget.event.title == ''){
                          validateNotNull(selfKey.currentState, widget.event, "title");
                        }
                        else if(widget.event.description == ''){
                          validateNotNull(selfKey.currentState, widget.event, "description");
                        }
                        else{
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => NewEventSecondView(widget.event))
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
        ),
    );

  }

  Future<Null> validateNotNull(ScaffoldState scaffold, Event event, String type) async{
    scaffold.showSnackBar(
      SnackBar(content: Text("Your $type can't be blank")),
    );
  }
}