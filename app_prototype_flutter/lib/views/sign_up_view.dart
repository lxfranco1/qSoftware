import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:auto_size_text/auto_size_text.dart";

final primaryColor = const Color(0xFF75A2EA);

enum AuthFormType {signIn, signUp}

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;

  SignUpView({Key key, @required this.authFormType}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {
  AuthFormType authFormType;
  _SignUpViewState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _email, _password, _name;

  void switchFormState(String state){
    formKey.currentState.reset();
    if(state == "signUp"){
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    }
    else{
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;



    return Scaffold(
      body: Container(
        color: primaryColor,
        height: _height,
        width: _width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: _height * 0.05),
              buildHeaderText(),
              SizedBox(height: _height * 0.05),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: buildInputs() + buildButtons(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AutoSizeText buildHeaderText() {
    String _headerText;
    if(authFormType == AuthFormType.signUp){
      _headerText = "Create New Account";
    }
    else{
      _headerText = "Sign In";

    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 35,
        color: Colors.white,
      ),
    );
  }

  List<Widget> buildInputs(){
    List<Widget> textFields = [];
    // if were in the sign up state add name
    if(authFormType == AuthFormType.signUp){
      textFields.add(
        TextFormField(
          style: TextStyle(fontSize: 22.0),
          decoration: buildSignUpInputDecoration("Name"),
          onSaved: (value) => _name = value,
        ),
      );
      textFields.add(SizedBox(height: 20,));
    }
    
    // add email & password
    textFields.add(
      TextFormField(
        style: TextStyle(fontSize: 22.0),
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) => _email = value,
      ),
    );
    textFields.add(SizedBox(height: 20,));
    textFields.add(
      TextFormField(
        style: TextStyle(fontSize: 22.0),
        decoration: buildSignUpInputDecoration("Password"),
        onSaved: (value) => _password = value,
      ),
    );
    textFields.add(SizedBox(height: 20,));

    return textFields;

  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0)),
        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
      );
  }

  List<Widget> buildButtons(){
    String _switchButtonText, _newFormState;

    if(authFormType == AuthFormType.signIn){
      _switchButtonText = "Create New Account";
      _newFormState = "signUp";
    } else{
      _switchButtonText = "Have an account? Sign In";
      _newFormState = "signIn";
    }

    return [
      FlatButton(
          child: Text(_switchButtonText, style: TextStyle(color: Colors.white),),
        onPressed: (){
            switchFormState(_newFormState);
        },
      )
    ];
  }
}
