import 'package:flutter/material.dart';
import '../Questions/Questionnaire.dart';
import '../Questions/QuestionnaireFirebase.dart';
import '../../Widgets/MyBottomNavigationBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
            child: StreamBuilder(
                stream: Firestore.instance.collection('overviewBank').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const CircularProgressIndicator();
                  return ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Questionnaire(questionnaireNumber: index);
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                  );
                }),
          ),
        ],
      )),
    );
  }
}
