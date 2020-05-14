import 'package:appprojekt/Widgets/MyBottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'Screens/Home/Questionnaire.dart';
import 'Overview.dart';
import 'route_generator.dart';
import 'package:appprojekt/Screens/CreateProfile/CaP.dart';
import 'package:appprojekt/Screens/Start/Start.dart';
import 'package:email_validator/email_validator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.teal[700], backgroundColor: Colors.grey[200]),
        // Initially display FirstPage
        home: MyBottomNavigationBar());
  }
}

/*void main() {
  return runApp(
    MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: Questionnaire().overviewBank.length,
          itemBuilder: (BuildContext context, int index) {
            return Questionnaire(questionnaireNumber: index);
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
        // child: ListView(
        // children: <Widget>[Questionnaire(), Questionnaire()],
      ),
      bottomNavigationBar: Home(),
    )),
  );
}*/
