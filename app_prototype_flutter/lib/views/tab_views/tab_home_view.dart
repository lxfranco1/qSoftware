import 'package:app_prototype_flutter/widgets/provider_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_prototype_flutter/models/Event.dart';
import 'package:app_prototype_flutter/views/flyer/flyer_view.dart';


class HomeView extends StatelessWidget {

  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: getAllEventsStreamSnapshot(context),
        builder: (context, snapshot){
          if(!snapshot.hasData) return const Text("Loading...");
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildEventCard(context, snapshot.data.documents[index]));
        }
      )
    );
  }

  Stream<QuerySnapshot> getUsersEventsStreamSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('userData').document(uid).collection('events').snapshots();
  }

  Stream<QuerySnapshot> getAllEventsStreamSnapshot(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('events').snapshots();
  }


  //Widget for the Cards
  Widget buildEventCard(BuildContext context, DocumentSnapshot event){

    String adminUser = 'F3KjUWbxDEYTJMA8gTDuHX8bsvo1';

    String currUserID;
    FirebaseAuth _auth = FirebaseAuth.instance;
    getCurrentUser () async {
      final FirebaseUser user = await auth.currentUser();
       currUserID = user.uid;
      if (currUserID == adminUser){
        visible = true;
        return;
      } else {
        visible = false;
      }
    }
    getCurrentUser();


    return new Container(
      child: new InkWell(
        onTap: () async {
          final db = Firestore.instance;
          QuerySnapshot snapshot = await db.collection('users').document(event['creatorsID']).collection('userData').getDocuments();
          String name = snapshot.documents[0].data['firstName'];
          //event['username'] = name;
          final newEvent = new Event(
            event['title'],
            event['date'].toDate(),
            event['description'],
            event['eventType'],
            event['attendance'],
            event['rating'],
            event['followers'],
            event['following'],
            event['creatorsID'],
            name,
            event['latitude'],
            event['longitude'],

          );
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Flyer(newEvent))
          );

        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(children: <Widget>[
                    Text((event['title'] == null )? "N/A" : event['title'], style: new TextStyle(fontSize: 30.0)),
                    Spacer(),
                  ],),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(children: <Widget>[
                    Text("${(event['date'] == null )? "N/A" : DateFormat('MM/dd/yyyy').format(event['date'].toDate()).toString()} at ${(event['date'] == null )? "N/A" : DateFormat('jm').format(event['date'].toDate()).toString()}"),
                    Spacer(),
                  ],),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(children: <Widget>[
                    Text((event['description'] == null )? "N/A" : event['description']),
                    Spacer(),
                    //Text("\$${event.price.toStringAsFixed(2)}", style: new TextStyle(fontSize: 20.0)),
                  ],),
                ),
                Visibility(
                    visible: visible,
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
                      Text('Delete Event', style: new TextStyle(fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      ),

                      onPressed: () async {
                          //remove event from db
                          String eventID;
                          QuerySnapshot events = await (Firestore.instance.collection('events').getDocuments());
                          var list = events.documents;
                          for(int i = 0; i < list.length; i++) {
                            if (list[i].data['title'] == event['title']) {
                              eventID = list[i].documentID;
                            }
                          }
                          Firestore.instance.collection('events').document(eventID).delete();

                      },
                    ),

                ),


              ],
            ),
          ),
        ),
      )
    );
  }

}
