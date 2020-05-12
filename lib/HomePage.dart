import 'package:flutter/material.dart';
import 'Questionnaire.dart';
import 'MyBottomNavigationBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
                'Hallo X! Wähle einen Fragebogen aus um ihn zu bearbeiten',
                style: TextStyle(fontSize: 30)),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: Questionnaire().overviewBank.length,
              itemBuilder: (BuildContext context, int index) {
                return Questionnaire(questionnaireNumber: index);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
        ],
      )),
    );
  }
}

/*

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
    );
  }
}*/
