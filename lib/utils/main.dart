import 'package:appprojekt/Widgets/MyBottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:appprojekt/Screens/CreateProfile/CaP.dart';
import 'package:appprojekt/Screens/Start/Start.dart';
import 'package:email_validator/email_validator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.teal[700], backgroundColor: Colors.grey[200]),
        // Initially display FirstPage
        home: MyBottomNavigationBar());
  }
}
