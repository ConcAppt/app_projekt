import 'package:flutter/material.dart';
import 'package:appprojekt/Widgets/MyBottomNavigationBar.dart';
import 'package:appprojekt/Screens/CreateProfile/List.dart';

class CaP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[700],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(), child: List()),
        ),
      ),
    );
  }
}
// TODO Implement this library.
