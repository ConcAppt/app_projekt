import 'package:flutter/material.dart';

class LogIn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: Log In Class
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Text(
              'Log In',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                letterSpacing: 3.0,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// TODO Implement this library.