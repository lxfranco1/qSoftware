import 'package:app_prototype_flutter/views/tab_views/tab_chat_view.dart';
import 'package:app_prototype_flutter/models/Event.dart';
import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/views/new_events/first_view.dart';
import 'package:app_prototype_flutter/views/tab_views/tab_profile.dart';
import 'package:app_prototype_flutter/views/tab_views/tab_home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/views/tab_views/test.dart';
import 'package:app_prototype_flutter/services/auth_service.dart';


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }

}

class _HomeState extends State<Home>{
  int _currentIndex = 0;
  final List<Widget> _children = [HomeView(), ProfileView()];

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> chat() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

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


    return  Scaffold(
      appBar: AppBar(
        title: Text("The A-List"),
        actions: <Widget>[



          IconButton(
            icon: Icon(Icons.chat),
              onPressed: () async {
                await chat();
              }
          )
        ],
      ),
      body: _children[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabbed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person_outline),
            title: new Text('Profile'),
          ),
        ],
      ),
      floatingActionButton: _bottomButtons(),
    );
  }


  void onTabbed(int index){
    setState((){
      _currentIndex = index;
    });
  }


  Widget _bottomButtons(){
    final newEvent = new Event(null, null, null, null, null, 0, 0.0, null, null, null);


    return _currentIndex == 0 ? FloatingActionButton.extended(
      onPressed: ()  {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewEvent(newEvent,)),
        );
      },
      label: Text("New Event"),
      icon: Icon(Icons.add),
    ) : null;
  }
}