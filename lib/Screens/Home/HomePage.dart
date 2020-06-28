import 'package:flutter/material.dart';
import '../Questions/Questionnaire.dart';
import '../../Widgets/MyBottomNavigationBar.dart';

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
            child: Text('Hello X!',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.lightGreen[700],
                    letterSpacing: 2)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text('Please choose a questionnaire to start.',
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: 2)),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: Questionnaire().overviewBank.length,
              itemBuilder: (BuildContext context, int index) {
                return Questionnaire(questionnaireNumber: index);
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
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
