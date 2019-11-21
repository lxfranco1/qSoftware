import 'package:app_prototype_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/widgets/provider_widget.dart';

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Party App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.undo),
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
          )
        ],
      ),
    );
  }
}

/*
class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          // center the children
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.favorite,
              size: 160.0,
              color: Colors.red,
            ),
            Text("First Tab")
          ],
        ),
      ),
    );
  }
}
 */