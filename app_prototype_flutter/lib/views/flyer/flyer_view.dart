import 'package:flutter/material.dart';
import 'text_section.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();


}
class _MyAppState extends State<MyApp> {
  var rating = 3.0;

  static const double _hPad = 16.0;
  @override
  Widget build(BuildContext context) {
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
              child: TextSection("Title"),
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
              padding: const EdgeInsets.fromLTRB(4.0, 5.0, _hPad, 4.0),
              child: MaterialButton(
                color: Colors.blueAccent,
                highlightColor: Colors.blueGrey,
                height: 55,
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
              child: MaterialButton(
                color: Colors.blueAccent,
                highlightColor: Colors.blueGrey,
                height: 55,
                minWidth: 80.0,
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),

                child:
                Text('Attend', style: new TextStyle(fontSize: 20.0,
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
              child: TextSection("Rate This Event"),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4.0, 8.0, _hPad, 4.0),
              child: SmoothStarRating(
                rating: rating,
                size: 45,
                starCount: 5,
                spacing: 2.0,
                onRatingChanged: (value) {
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
