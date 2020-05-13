import'package:flutter/material.dart';
import'package:appprojekt/Widgets/MyBottomNavigationBar.dart';
import'package:appprojekt/Screens/CreateProfile/List.dart';

class CaP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[700],
        title: Text(
          'Create a Profile',
          style: TextStyle(
              color: Colors.grey[100],
              fontSize: 30.0,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              letterSpacing: 4.0
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: List()
          ),
        ),
      ),
    );
  }
}
// TODO Implement this library.