import 'package:app_prototype_flutter/models/Event.dart';
import 'package:app_prototype_flutter/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:share/share.dart';
import 'text_section.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Flyer extends StatefulWidget {
  final Event event;
  const Flyer(this.event);

  @override
  State<StatefulWidget> createState() => _FlyerState();

}

class _FlyerState extends State<Flyer> {
  var rating = 2.0;
  final db = Firestore.instance;

  static const double _hPad = 16.0;
  @override
  Widget build(BuildContext context) {
    String title = widget.event.title;
    String date = widget.event.date.toString();
    String eventType;
    String creatorID;
    if (widget.event.eventType == null){
      eventType = "Event";
    } else {
      eventType = widget.event.eventType;
    }
    if (widget.event.creatorsID == null){
      creatorID = "ID";
    } else {
      creatorID = widget.event.creatorsID;
    }
    String description = widget.event.description;
    int attendance = widget.event.attendance;



    return Scaffold(
      appBar: AppBar(
        title: const Text('Event'),
      ),
      body: SingleChildScrollView(
          child: Column(
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
                padding: const EdgeInsets.fromLTRB(4.0, 0.0, _hPad, 4.0),
                child: TextSection(creatorID),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(4.0, 5.0, 205, 4.0),
                child: MaterialButton(
                  color: Colors.blueAccent,
                  highlightColor: Colors.blueGrey,
                  height: 48,
                  minWidth: 80.0,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child:
                  Text('Follow User', style: new TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  ),

                  onPressed: () {
                    //
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(4.0, 34.0, _hPad, 4.0),
                child: TextSection(description),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(4.0, 14.0, _hPad, 4.0),
                child: TextSection(attendance.toString() + " people attending"),
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

                  onPressed: () {
                    setState(() {
                      widget.event.attendance++;
                    });
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
                      setState(() {
                        rating = value;
                      });
                    },
                  )
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
                  Text('Share with email/SMS', style: new TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  ),

                  onPressed: () => share(context, widget.event)
                ),
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
                  Text('Share with Twitter', style: new TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  ),

                  onPressed: () async {
                    var response = await FlutterShareMe().shareToTwitter(
                        msg: "Come to my event: " + widget.event.title + " at " + widget.event.toString() );
                  },
                ),
              ),
            ]
      ),
    ),
    );
  }
  void share(BuildContext context, Event event){
    final String text = "Come to my event: ${event.title} at ${event.date.toString()}";
    Share.share(text, subject: event.description);
  }
}

