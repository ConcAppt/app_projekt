import 'package:appprojekt/Screens/Home/HomePageFirebase.dart';
import 'package:flutter/material.dart';
import '../Screens/Evaluation/EvaluationPageFirebase.dart';
import '../Screens/Profile/ProfilePage.dart';
import '../Screens/Settings/SettingsPage.dart';

class MyBottomNavigationBar extends StatefulWidget {
  MyBottomNavigationBar({Key key, this.currentIndex}) : super(key: key);
  int currentIndex;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MyBottomNavigationBar> {
  final List<Widget> _children = [
    HomePage(),
    EvaluationPage(), //make real screen
    ProfilePage(),
    SettingsPage(), //same here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[widget.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.currentIndex,
          type: BottomNavigationBarType.shifting,
          iconSize: 35,
          backgroundColor: Colors.lightGreen[700],
          selectedItemColor: Colors.grey[200],
          unselectedItemColor: Colors.black87,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                backgroundColor: Colors.lightGreen[700]),
            BottomNavigationBarItem(
                icon: Icon(Icons.timeline),
                title: Text('Evaluation'),
                backgroundColor: Colors.lightGreen[700]),
            BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity),
                title: Text('Profile'),
                backgroundColor: Colors.lightGreen[700]),
            BottomNavigationBarItem(
                icon: Icon(Icons.toc),
                title: Text('More'),
                backgroundColor: Colors.lightGreen[700]),
          ],
          onTap: (index) {
            setState(() {
              widget.currentIndex = index;
            });
          }),
    );
  }
}
