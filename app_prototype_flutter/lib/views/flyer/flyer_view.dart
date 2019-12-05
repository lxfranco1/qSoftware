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
  var rating = 3.2;
  final db = Firestore.instance;

  static const double _hPad = 16.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(4.0, 0.0, _hPad, 4.0),
              child: TextSection(widget.event.title),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4.0, 0.0, _hPad, 4.0),
              child: TextSection("Date"),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4.0, 0.0, _hPad, 4.0),
              child: TextSection("EventType"),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4.0, 0.0, _hPad, 4.0),
              child: TextSection("Username"),
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
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => SecondRoute()),);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4.0, 34.0, _hPad, 4.0),
              child: TextSection("Description"),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4.0, 14.0, _hPad, 4.0),
              child: TextSection("X people attending"),
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
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => SecondRoute()),);
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
            )
          ]
      ),
    );
  }
  void share(BuildContext context, Event event){
    final String text = "Come to my event: ${event.title} at ${event.date.toString()}";
    Share.share(text, subject: event.description);
  }
}

