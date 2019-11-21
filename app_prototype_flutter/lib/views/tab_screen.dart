import 'package:flutter/material.dart';


class TabScreen extends StatefulWidget {
  final Color color;
  TabScreen(this.color);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int currentTabIndex = 0;
  List<Widget> tabs = [
    TabScreen(Colors.green),
    TabScreen(Colors.red),
    TabScreen(Colors.blue)
  ];
  onTapped(int index){
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}
