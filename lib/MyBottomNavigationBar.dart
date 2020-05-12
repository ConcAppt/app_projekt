import 'package:appprojekt/HomePage.dart';
import 'package:flutter/material.dart';
import 'EvaluationPage.dart';
import 'ProfilePage.dart';
import 'SettingsPage.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    EvaluationPage(),
    ProfilePage(),
    SettingsPage(),
  ];
//Test
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.shifting,
          iconSize: 35,
          backgroundColor: Colors.blueGrey,
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xFFF434A50),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                backgroundColor: Colors.blueGrey),
            BottomNavigationBarItem(
                icon: Icon(Icons.timeline),
                title: Text('Auswertung'),
                backgroundColor: Colors.blueGrey),
            BottomNavigationBarItem(
                icon: Icon(Icons.folder_shared),
                title: Text('Profil'),
                backgroundColor: Colors.blueGrey),
            BottomNavigationBarItem(
                icon: Icon(Icons.toc),
                title: Text('Mehr'),
                backgroundColor: Colors.blueGrey),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}
