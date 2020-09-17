import 'dart:convert';

import 'package:appprojekt/Widgets/UserProvider_InWi.dart';
import 'package:appprojekt/data/Database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SwipingQuestionsEvaluation.dart';
import 'WheelQuestionsEvaluation.dart';
import 'MultipleChoiceEvaluation.dart';
import '../../models/user.dart';
import '../../Widgets/UserProvider_InWi.dart';

class EvaluationPage extends StatefulWidget {
  @override
  _EvaluationPageState createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<EvaluationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0),
        child: AppBar(
          backgroundColor: Colors.lightGreen[400],
          automaticallyImplyLeading: false,
        ),
      ), // backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Text('Hello ${UserProvider.of(context).user.name}!',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.lightGreen[700],
                    letterSpacing: 2)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text('Have a look at the results of the questionnaires',
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
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FutureBuilder(
                          future: DBProvider.db.getRecords(UserProvider.of(context).user.email,
                              snapshot.data.documents[index]['questionnaireName'].toUpperCase()),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
                            if (!snap.hasData) {
                              return Text('No Data available');
                            }
                            var list = jsonDecode(snap.data);
                            int value = list[0]["count(id)"];
                            return _buildListTile(context, snapshot.data.documents[index], value);
                          });
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

enum Department { back, start }

Widget _buildListTile(BuildContext context, DocumentSnapshot document, int value) {
  return Card(
    color: Colors.lightGreen[600].withOpacity(0.7),
    child: ListTile(
      title: Text(
        (document['questionnaireName'] + "\t"),
        style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            fontSize: 15),
      ),
      subtitle: Center(
        child: Text(
          (document['questionnaireDescription'] + "\n\n" + 'Records: $value'),
          style: TextStyle(
              color: Colors.black87,
              fontFamily: 'Montserrat',
              letterSpacing: 1.5,
              fontWeight: FontWeight.w400,
              fontSize: 13),
        ),
      ),
      dense: true,
      isThreeLine: true,
      onTap: () {
        Future<void> openDialog() async {
          User newuser = UserProvider.of(context).user;
          switch (await showDialog<Department>(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: const Text('Do you want to look at the results?',
                      textAlign: TextAlign.center),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.lightGreen[600].withOpacity(0.7),
                          ),
                          child: SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, Department.back);
                            },
                            child: const Text('Back'),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.lightGreen[600].withOpacity(0.7),
                          ),
                          child: SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, Department.start);
                            },
                            child: const Text('Start'),
                          ),
                        ),
                      ],
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                );
              })) {
            case Department.back:
              //....
              break;
            case Department.start:
              print('start gedrückt');
              if (document['type'] == 'SliderQuestion') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProvider(
                              user: newuser,
                              child: BuildSwipingEval(
                                quename: document['questionnaireName'],
                              ),
                            )));
              } else if (document['type'] == 'WheelQuestion') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProvider(
                              user: newuser,
                              child: BuildWheelEval(
                                quename: document['questionnaireName'],
                              ),
                            )));
              } else if (document['type'] == 'MultipleChoiceQuestion') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProvider(
                              user: newuser,
                              child: BuildMCEval(
                                quename: document['questionnaireName'],
                              ),
                            )));
              }
              break;
          }
        }

        openDialog();
      },
    ),
  );
}
