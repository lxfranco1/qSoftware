import 'package:flutter/material.dart';
import 'package:app_prototype_flutter/views/first_view.dart';
import 'package:app_prototype_flutter/views/sign_up_view.dart';
import 'package:app_prototype_flutter/services/auth_service.dart';
import 'package:app_prototype_flutter/views/navigation_view.dart';
import 'package:app_prototype_flutter/widgets/provider_widget.dart';

void main() => runApp(MyApp());
//test commit
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeController(),
          '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
          '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
          '/anonymousSignIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.anonymous),
          '/convertUser':(BuildContext context) => SignUpView(authFormType: AuthFormType.convert),

        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ThemeData(

    );
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home() : FirstView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}


