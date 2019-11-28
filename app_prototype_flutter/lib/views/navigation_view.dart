import 'package:app_prototype_flutter/services/auth_service.dart';
import 'package:app_prototype_flutter/views/tab_views/tab_chat_view.dart';
import 'package:app_prototype_flutter/models/Event.dart';
import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/views/new_events/first_view.dart';
import 'package:app_prototype_flutter/widgets/provider_widget.dart';
import 'package:app_prototype_flutter/views/tab_views/tab_profile.dart';
import 'package:app_prototype_flutter/views/tab_views/tab_home_view.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }

}

class _HomeState extends State<Home>{
  int _currentIndex = 0;
  final List<Widget> _children = [HomeView(), ChatView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    final newEvent = new Event(null, null, null, null, null, null);

    return  Scaffold(
      appBar: AppBar(
        title: Text("The A-List"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.playlist_add),

            onPressed: ()  {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewTripFirstView(event: newEvent,)),
              );
            },
          ),

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
          ),

          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: ()  {
              Navigator.of(context).pushNamed('/convertUser');
            },
          ),
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
            icon: new Icon(Icons.chat),
            title: new Text('Chat'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person_outline),
            title: new Text('Profile'),
          ),
        ],
      ),
    );
  }

  void onTabbed(int index){
    setState((){
      _currentIndex = index;
    });
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

/*
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
 */