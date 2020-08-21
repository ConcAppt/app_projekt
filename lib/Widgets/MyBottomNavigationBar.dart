import 'package:appprojekt/Screens/Home/HomePageFirebase.dart';
import 'package:appprojekt/Screens/Settings/SettingsPage.dart';
import 'package:flutter/material.dart';
import '../Screens/Evaluation/EvaluationPageFirebase.dart';
import '../Screens/Profile/ProfilePage.dart';
import '../Screens/Questions/SwipingQuestionsFirebase.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MyBottomNavigationBar> {
  int _currentIndex = 2;
  final List<Widget> _children = [
    HomePage(),
    EvaluationPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
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
              _currentIndex = index;
            });
          }),
    );
  }
}
