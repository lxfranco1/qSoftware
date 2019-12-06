import 'package:app_prototype_flutter/models/Event.dart';
import 'package:app_prototype_flutter/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:share/share.dart';
import 'text_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
FirebaseAuth auth = FirebaseAuth.instance;
class Flyer extends StatefulWidget {
  final Event event;
  const Flyer(this.event);

  @override
  State<StatefulWidget> createState() => _FlyerState();

}

class _FlyerState extends State<Flyer> {

  final db = Firestore.instance;
  bool _isButtonDisabled;

  static const double _hPad = 16.0;
  @override
  Widget build(BuildContext context) {
    double rating = widget.event.rating;
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
    String eventID = "id";
    String username = widget.event.username;


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
                child: TextSection(username),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(4.0, 5.0, 205, 4.0),
                child: MaterialButton(
                  color: Colors.redAccent,
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
                  onPressed: () async {
                    String userID;
                    final uid = await Provider.of(context).auth.getCurrentUID();
                    print("current user: ");
                    print(uid); //current user
//                    print("Followed");

                    QuerySnapshot events = await (db.collection('events').getDocuments());
                    QuerySnapshot users = await (db.collection('users').getDocuments());
//                    QuerySnapshot userdata = await (db.collection(users).getDocuments());
//                    print(widget.event.documentID);

                    var list = events.documents;
                    var list2 = users.documents;

                    for(int i = 0; i < list.length; i++) {
                      if (list[i].data['title'] == widget.event.title) {
                        eventID = list[i].documentID;
                      }
                    }
//                    print(eventID); //event ID
                    for(int j = 0; j < list.length; j++) {
                      if (list[j].documentID == eventID) {
                        userID = list[j].data['creatorsID'];
                      }
                    }

                    //name of event user
                    QuerySnapshot snapshot = await db.collection('users').document(userID).collection('userData').getDocuments();
                    String getname = snapshot.documents[0].data['firstName'];

                    //put name under my following;
                    snapshot = await db.collection('users').document(uid).collection('userData').getDocuments();
                    snapshot.documents[0].data['followers'].add(getname);

                    print("creator: ");
                    print(userID); //creatorID
                    print("name: ");
                    print(getname);
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
                  color: Colors.redAccent,
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

                  onPressed: () async {
                    QuerySnapshot events = await (db.collection('events').getDocuments());
                    var list = events.documents;
                    for(int i = 0; i < list.length; i++) {
                      if (list[i].data['title'] == widget.event.title) {
                        eventID = list[i].documentID;
                      }
                    }

                    setState(() {
                      widget.event.attendance++;
                      db.collection('events').document(eventID).updateData({'attendance' : widget.event.attendance});
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
                    onRatingChanged: (value) async {
                      QuerySnapshot events = await (db.collection('events').getDocuments());
                      var list = events.documents;
                      for(int i = 0; i < list.length; i++) {
                        if (list[i].data['title'] == widget.event.title) {
                          eventID = list[i].documentID;
                        }
                      }
                      setState(() {
                        rating = value;
                        widget.event.rating = value;
                        db.collection('events').document(eventID).updateData({'rating' : rating});
                      });
                    },
                  )
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(4.0, 14.0, 205, 4.0),
                child: MaterialButton(
                    color: Colors.redAccent,
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
                  color: Colors.redAccent,
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
  Future<String> getCurrentUser() async {
    FirebaseUser user = await auth.currentUser();
    return user.uid;
  }

}

