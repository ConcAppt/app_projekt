import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:appprojekt/Screens/LogIn/Log.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Log In Class
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[700],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(50.0),
            child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(), child: LogList()
                //lul
                ),
          ),
        ),
      ),
    );
  }
}
// TODO Implement this library.
