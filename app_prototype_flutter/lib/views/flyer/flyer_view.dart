import 'package:app_prototype_flutter/models/Event.dart';
import 'package:app_prototype_flutter/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'text_section.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Flyer extends StatefulWidget {
  final Event event;
  const Flyer(this.event);

  @override
  State<StatefulWidget> createState() => _FlyerState();

}

class _FlyerState extends State<Flyer> {
  var rating = 3.2;
  final db = Firestore.instance;

  static const double _hPad = 16.0;
  @override
  Widget build(BuildContext context) {
    String title = widget.event.title;
    String date = widget.event.date.toString();
    String eventType;
    String creatorsID;
    String description;
    if (widget.event.eventType != null){
      eventType = widget.event.eventType;
    } else {
      eventType = "Event";
    }
    if (widget.event.creatorsID != null){
      creatorsID = widget.event.creatorsID;
    } else {
      creatorsID = "ID";
    }
    if (widget.event.description != null){
      description = widget.event.description;
    } else {
      description = " ";
    }

    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Event'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(4.0, 0.0, _hPad, 4.0),
              child: TextSection(title),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4.0, 0.0, _hPad, 4.0),
              child: TextSection(date),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4.0, 0.0, _hPad, 4.0),
              child: TextSection(eventType),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4.0, 0.0, _hPad, 1.0),
              child: TextSection(creatorsID),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4.0, 1.0, 275, 4.0),
              child: MaterialButton(
                color: Colors.blueAccent,
                highlightColor: Colors.blueGrey,
                height: 35,
                minWidth: 80.0,
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),

                child:
                Text('Follow User', style: new TextStyle(fontSize: 15.0,
                    fontWeight: FontWeight.bold),
                ),

                onPressed: () {
                  //add to followed users here
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4.0, 34.0, _hPad, 4.0),
              child: TextSection("Descrption: \n" + description),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4.0, 14.0, _hPad, 4.0),
              child: TextSection(widget.event.attendance.toString() +  " people attending"),
            ),

              Container(
                padding: const EdgeInsets.fromLTRB(4.0, 14.0, 205, 4.0),
                child: MaterialButton(
                  color: Colors.blueAccent,
                  highlightColor: Colors.blueGrey,
                  height: 48.0,
                  minWidth: 30.0,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child:
                  Text('Attend Event', style: new TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  ),

                onPressed: () async{
                  //increment attendance here
                  DocumentSnapshot snapshot = await db.collection('events').document("2zbAdSpuL2bGYry8kPID").get();
                  int attendance = snapshot.data['attendance'];
                  attendance++;
                  await db.collection('events').document("2zbAdSpuL2bGYry8kPID").updateData({'attendance': attendance});

                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4.0, 34.0, _hPad, 4.0),
              alignment: Alignment.center,
              child: TextSection("Rate This Event"),
            ),
            Container(
              //padding: const EdgeInsets.fromLTRB(4.0, 8.0, _hPad, 4.0),
              alignment: Alignment.center,
              child: SmoothStarRating(
                rating: rating,
                size: 45,
                starCount: 5,
                spacing: 1.5,
                onRatingChanged: (value) {
                  //save rating here
                  setState(() {
                    rating = value;
                  });
                },
              )
            )
          ]
        ),
      ),
    );
  }
}

