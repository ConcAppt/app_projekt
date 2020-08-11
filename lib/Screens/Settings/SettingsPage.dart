import 'package:appprojekt/Screens/Start/Start.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _EvaluationPageState createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Start()),
          );
        },
          color: Colors.lightGreen[700],
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Text(
            'Logout',
            style: TextStyle(
              fontSize: 28.0,
              fontFamily: 'Montserrat',
              letterSpacing: 3.0,
              color: Colors.grey[100],
              fontWeight: FontWeight.w500,
            ),
          ),),
      ),
    );
  }
}
