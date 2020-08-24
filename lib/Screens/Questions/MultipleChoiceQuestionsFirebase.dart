import 'dart:convert';

import 'package:appprojekt/data/Database.dart';
import 'package:appprojekt/models/data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Widgets/MyBottomNavigationBar.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../models/user.dart';

enum answerAlternatives { No, sometimes, often }

class BuildMultipleChoiceQuestionnaire extends StatefulWidget {
  BuildMultipleChoiceQuestionnaire({Key key, this.quename}) : super(key: key);
  final quename;

  @override
  _BuildMultipleChoiceQuestionnaireState createState() =>
      _BuildMultipleChoiceQuestionnaireState();
}

class _BuildMultipleChoiceQuestionnaireState
    extends State<BuildMultipleChoiceQuestionnaire> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  var myFeedbackText = 'neutral';
  var sliderValue = 4.0;
  int selectedItem;
  answerAlternatives _alternatives;
  Map answers = Map<String, String>();
  String answerstr;

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.lightGreen, //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            widget.quename.toUpperCase(),
            //textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: Colors.lightGreen[700],
                letterSpacing: 2),
          ),
        ),
        body: UserProvider(
          user: UserProvider.of(context).user,
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('MultipleChoiceQuestions')
                  .document(widget.quename)
                  .collection("Questions")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) return CircularProgressIndicator();
                return Container(
                    child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: <Widget>[
                            Stack(
                                alignment: AlignmentDirectional.topCenter,
                                children: <Widget>[
                                  SmoothPageIndicator(
                                    controller: _pageController,
                                    count: snapshot.data.documents.length,
                                    effect: ScrollingDotsEffect(
                                        activeDotColor: Colors.lightGreen[700],
                                        dotColor: Colors.grey,
                                        dotHeight: 10,
                                        dotWidth: 10,
                                        maxVisibleDots: 11,
                                        spacing: 15.0),
                                  )
                                ]),
                            PageView.builder(
                                physics: new NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                controller: _pageController,
                                onPageChanged: _onPageChanged,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (ctx, i) {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 0.0),
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                            child: _buildDescriptionItem(
                                                snapshot.data.documents[i])),
                                        Expanded(
                                            child: _buildCheckBoxList(
                                                snapshot.data.documents[i])),
                                        Container(
                                          child: FloatingActionButton.extended(
                                              icon: Icon(Icons.navigate_next),
                                              label: Text('Next'),
                                              backgroundColor:
                                                  Colors.lightGreen[700],
                                              onPressed: () {
                                                User newuser =
                                                    UserProvider.of(context)
                                                        .user;
                                                answers['Question ${i + 1}'] =
                                                    answerstr;
                                                //TODO check Answer
                                                Future<void>
                                                    _showMyDialog() async {
                                                  return showDialog<void>(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    // user must tap button!
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(),
                                                        title:
                                                            Text('Attention'),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: ListBody(
                                                            children: <Widget>[
                                                              Text(
                                                                  'Please select an answer option'),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child: Text(
                                                              'Okay',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .lightGreen,
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontSize: 20.0,
                                                                letterSpacing:
                                                                    2,
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }

                                                if (_alternatives == null) {
                                                  _showMyDialog();
                                                } else {
                                                  if (i ==
                                                      snapshot.data.documents
                                                              .length -
                                                          1) {
                                                    Future<void>
                                                        _showEndDialog() async {
                                                      return showDialog<void>(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        // user must tap button!
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            shape:
                                                                RoundedRectangleBorder(),
                                                            title: Text(
                                                                'Attention'),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: ListBody(
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                      'Questionnaire has been completely processed '),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                child: Text(
                                                                  'Okay',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .lightGreen,
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    fontSize:
                                                                        20.0,
                                                                    letterSpacing:
                                                                        2,
                                                                  ),
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  Data data = Data(
                                                                      id: null,
                                                                      email: newuser
                                                                          .email,
                                                                      date:
                                                                          null,
                                                                      questionnaire: widget
                                                                          .quename
                                                                          .toUpperCase(),
                                                                      answers:
                                                                          jsonEncode(
                                                                              answers));
                                                                  DBProvider.db
                                                                      .newQuestionnaire(
                                                                          data);
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => UserProvider(
                                                                            user:
                                                                                newuser,
                                                                            child:
                                                                                MyBottomNavigationBar())),
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }

                                                    _showEndDialog();
                                                  } else {
                                                    _pageController.nextPage(
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        curve: Curves.easeIn);
                                                    _alternatives = null;
                                                  }
                                                }
                                              }),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
              }),
        ));
  }

  Container _buildCheckBoxList(DocumentSnapshot document) {
    return Container(
      child: Column(
        children: <Widget>[
          RadioListTile<answerAlternatives>(
            activeColor: Colors.lightGreen[700],
            title: const Text('Not at all applicable',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,
                  letterSpacing: 2,
                )),
            value: answerAlternatives.No,
            groupValue: _alternatives,
            onChanged: (answerAlternatives value) {
              setState(() {
                _alternatives = value;
                answerstr = 'Not at all applicable';
              });
            },
          ),
          RadioListTile<answerAlternatives>(
            activeColor: Colors.lightGreen[700],
            title: const Text('A little or sometimes applicable',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,
                  letterSpacing: 2,
                )),
            value: answerAlternatives.sometimes,
            groupValue: _alternatives,
            onChanged: (answerAlternatives value) {
              setState(() {
                _alternatives = value;
                answerstr = 'A little or sometimes applicable';
              });
            },
          ),
          RadioListTile<answerAlternatives>(
            activeColor: Colors.lightGreen[700],
            title: const Text('Clearly or often applicable',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,
                  letterSpacing: 2,
                )),
            value: answerAlternatives.often,
            groupValue: _alternatives,
            onChanged: (answerAlternatives value) {
              setState(() {
                _alternatives = value;
                answerstr = 'Clearly or often applicable';
              });
            },
          ),
        ],
      ),
    );
  }

  Container _buildDescriptionItem(DocumentSnapshot document) {
    return Container(
      height: 10,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(document['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen[700],
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                letterSpacing: 2,
              )),
          SizedBox(height: 7),
          Text(document['description'],
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontSize: 14.0,
                letterSpacing: 2,
              )),
        ],
      ),
    );
  }
}
