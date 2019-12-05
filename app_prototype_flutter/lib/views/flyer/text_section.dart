import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  String _text;

  TextSection(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

      ),
      child: Text(_text, style: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300,
      fontSize: 20.0,
      color: Colors.black,)
      ),
    );
  }

}