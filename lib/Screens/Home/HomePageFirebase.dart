import 'package:appprojekt/Screens/Questions/SwipingQuestionsFirebase.dart';
import 'package:appprojekt/Screens/Questions/MultipleChoiceQuestionsFirebase.dart';
import 'package:appprojekt/Screens/Questions/WheelQuestionsFirebase.dart';
import 'package:flutter/material.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../models/user.dart';
import '../Questions/PageViewUpdate.dart';
import '../../Ablage/Questionnaire.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0),
        child: AppBar(
          backgroundColor: Colors.lightGreen[400],
          automaticallyImplyLeading: false,
        ),
      ),// backgroundColor: Colors.white,
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
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildListTile(context, snapshot.data.documents[index]);
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

Widget _buildListTile(BuildContext context, DocumentSnapshot document) {
  return UserProvider(
    user: UserProvider.of(context).user,
    child: Card(
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
            (document['questionnaireDescription'] + "\n\n" + document['questionnaireScope']),
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
          User newuser = UserProvider.of(context).user;
          Future<void> openDialog() async {
            switch (await showDialog<Department>(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: const Text('Do you want to take the test now?'),
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
                if (document['type'] == 'SwipingQuestion') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProvider(
                                user: newuser,
                                child: BuildSwipingQuestionnaire(
                                  quename: document['questionnaireName'],
                                ),
                              )));
                } else if (document['type'] == 'WheelQuestion') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProvider(
                                user: newuser,
                                child: BuildWheelQuestionnaire(
                                  quename: document['questionnaireName'],
                                ),
                              )));
                } else if (document['type'] == 'MultipleChoiceQuestion') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProvider(
                                user: newuser,
                                child: BuildMultipleChoiceQuestionnaire(
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
    ),
  );
}
