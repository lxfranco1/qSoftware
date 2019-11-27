import 'package:app_prototype_flutter/views/navigation_view.dart';
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileView()),);
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
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,


          children: <Widget>[

            new MaterialButton(child:

            Text('Followers', style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),


              disabledColor: Colors.lightBlueAccent,
              highlightColor: Colors.redAccent,
              height: 100,
              minWidth: 375,
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),);
              },

            ),
            new MaterialButton(
              child: Text('Following', style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              disabledColor: Colors.lightBlueAccent,
              height: 100,
              minWidth: 375,
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),



            ),
            new MaterialButton(child: Text('Events', style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
              disabledColor: Colors.lightBlueAccent,
              height: 100,
              minWidth: 375,
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),);
              },

            ),
            new MaterialButton(child: Text('Settings', style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),

              disabledColor: Colors.lightBlueAccent,
              height: 100,
              minWidth: 375,
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            new MaterialButton(child: Text('Logout', style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
              disabledColor: Colors.lightBlueAccent,
              height: 100,
              minWidth: 375,
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ),
      ),
    );
  }
}

