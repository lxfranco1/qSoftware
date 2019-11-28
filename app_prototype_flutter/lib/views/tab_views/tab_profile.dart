import 'package:app_prototype_flutter/views/navigation_view.dart';
import 'package:app_prototype_flutter/services/auth_service.dart';
import 'package:app_prototype_flutter/widgets/provider_widget.dart';

import 'package:flutter/material.dart';


//class ProfileView extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      color: Colors.blueAccent,
//    );
//  }
//}
//void doing(){
//
//}
//
//class ProfileView extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialButton(
//     // disabledColor: Colors.pinkAccent,
//      //splashColor: Colors.redAccent,
//      //color: Colors.blueAccent,
//         child: Text('Events'),
//      onPressed: doing,
//      highlightColor: Colors.redAccent,
//    );
//
//  }
//}


//class FirstRoute extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//
//      body: Center(
//        child: RaisedButton(
//          child: Text('Followers'),
//          onPressed: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => SecondRoute()),
//            );
//          },
//        ),
//      ),
//    );
//  }
//}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Followers"),
      ),
      body: Center(
        child: RaisedButton(
//          onPressed: () {
//            Navigator.pop(context);
//          },

          onPressed: () {
            // TODO: Make this go back to the Profile part of the page and not the home
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: ProfileView(),
  ));
}







class ProfileView extends StatelessWidget {
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
                    Text('Followers', style: new TextStyle(fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                    ),

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondRoute()),);
                  },
                ),
              ),



              Padding(
                padding: EdgeInsets.only(top: 16.0,),
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
                  child: Text('Following', style: new TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
                  onPressed: (){

                  },
                ),
              ),

              //TODO: make it so that this button only show events created by user
              Padding(
                padding: EdgeInsets.only(top: 16.0,),
                child:
                new MaterialButton(
                  color: Colors.blueAccent,
                  highlightColor: Colors.blueGrey,
                  height: 75,
                  minWidth: MediaQuery.of(context).size.width,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('Events', style: new TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),);
                  },

                ),

              ),



              Padding(
                padding: EdgeInsets.only(top: 16.0,),
                child:
                new MaterialButton(
                  color: Colors.blueAccent,
                  highlightColor: Colors.blueGrey,
                  height: 75,
                  // the width of this button
                  minWidth: MediaQuery.of(context).size.width,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child: Text('Settings', style: new TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  ),
                  onPressed: (){

                  },
                ),
              ),



              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: new MaterialButton(
                  color: Colors.blueAccent,
                  highlightColor: Colors.blueGrey,
                  height: 75,
                  minWidth: MediaQuery.of(context).size.width,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child: Text('Logout', style: new TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  ),

                  onPressed: () async {
                    try{
                      AuthService auth = Provider.of(context).auth;
                      await auth.signOut();
                      print("Signed Out");
                      Navigator.of(context).pushReplacementNamed('/home');
                    } catch(e){
                      print(e);
                    }
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

