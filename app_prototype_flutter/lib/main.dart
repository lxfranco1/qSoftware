import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/views/first_view.dart';
import 'package:app_prototype_flutter/views/sign_up_view.dart';
import 'package:app_prototype_flutter/services/auth_service.dart';
import 'package:app_prototype_flutter/views/home_view.dart';
import 'package:app_prototype_flutter/widgets/provider_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirstView(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomeController(),
        '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
        '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
      },
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? MyHomePage() : FirstView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}


