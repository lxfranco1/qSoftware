import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/views/tab_views/test.dart';
import 'package:app_prototype_flutter/services/auth_service.dart';


class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}


class _ChatState extends State<Chat> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async {
    FirebaseUser user = await  FirebaseAuth.instance.currentUser();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Test(
          user: user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 0.0,),
                child:
                new MaterialButton(
                  color: Colors.blueAccent,
                  highlightColor: Colors.blueGrey,
                  height: 75,
                  minWidth: MediaQuery.of(context).size.width,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child:
                  Text('Test', style: new TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  ),

                  onPressed: () async {
                    await loginUser();
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
