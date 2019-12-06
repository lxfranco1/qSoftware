import 'package:app_prototype_flutter/views/navigation_view.dart';
import 'package:app_prototype_flutter/services/auth_service.dart';
import 'package:app_prototype_flutter/widgets/provider_widget.dart';

import 'package:flutter/material.dart';

class events_view extends StatelessWidget {
  String _todoName = "Test";
  @override
  Widget build(BuildContext context) {
    var itemTile = new ListTile(
      title: new Text("$_todoName"),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
      ),
      body: new ListView(
      children: <Widget>[itemTile,
      ]
      ),
    );
  }
}
//onPressed: () async {
////final uid = await Provider.of(context).auth.getCurrentUID();
//event.creatorsID = (await FirebaseAuth.instance.currentUser()).uid;
//// SAVEING DATA
//await db.collection("events").add(event.toJson());
////print events created by this creator