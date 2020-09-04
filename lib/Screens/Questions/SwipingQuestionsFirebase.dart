import 'dart:convert';

import 'package:appprojekt/Screens/Home/HomePageFirebase.dart';
import 'package:intl/intl.dart';
import 'package:appprojekt/data/Database.dart';
import 'package:appprojekt/models/data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Widgets/MyBottomNavigationBar.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../models/user.dart';
import 'package:appprojekt/Screens/Start/Start.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:weekday_selector/weekday_selector.dart';

class BuildSwipingQuestionnaire extends StatefulWidget {
  BuildSwipingQuestionnaire({Key key, this.quename}) : super(key: key);
  final quename;
  @override
  _BuildSwipingQuestionnaireState createState() => _BuildSwipingQuestionnaireState();
}

class _BuildSwipingQuestionnaireState extends State<BuildSwipingQuestionnaire> {
  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);
  var myFeedbackText = 'neutral';
  var sliderValue = 4.0;
  Map answers = Map<String, dynamic>();

  bool state = false;
  var dateTimePicker;

  final values = List.filled(7, true);
  var days = List.filled(7, true);

  FlutterLocalNotificationsPlugin fltrNotification;

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

  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(androidInitilize, iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: _notificationSelected);
  }

  Future _showNotification(DateTime dateTimePicker) async {
    int hour = int.parse(DateFormat.H().format(dateTimePicker));
    int minute = int.parse(DateFormat.m().format(dateTimePicker));
    int second = int.parse(DateFormat.s().format(dateTimePicker));
    Time notificationTime = Time(hour, minute, second);

    String title = "Hey there!";
    String body = "Your timer for ${widget.quename} has expired. Please "
        "have a "
        "look and answer the questionnaire again";
    var androidDetails = new AndroidNotificationDetails(
      "Channel ID",
      title,
      body,
      importance: Importance.Max,
    );

    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails = new NotificationDetails(androidDetails, iSODetails);

    if (days[0] == true) {
      fltrNotification.showWeeklyAtDayAndTime(
          0, title, body, Day.Monday, notificationTime, generalNotificationDetails);
    }
    if (days[1] == true) {
      fltrNotification.showWeeklyAtDayAndTime(
          1, title, body, Day.Tuesday, notificationTime, generalNotificationDetails);
    }
    if (days[2] == true) {
      fltrNotification.showWeeklyAtDayAndTime(
          2, title, body, Day.Wednesday, notificationTime, generalNotificationDetails);
    }
    if (days[3] == true) {
      fltrNotification.showWeeklyAtDayAndTime(
          3, title, body, Day.Thursday, notificationTime, generalNotificationDetails);
    }
    if (days[4] == true) {
      fltrNotification.showWeeklyAtDayAndTime(
          4, title, body, Day.Friday, notificationTime, generalNotificationDetails);
    }
    if (days[5] == true) {
      fltrNotification.showWeeklyAtDayAndTime(
          5, title, body, Day.Saturday, notificationTime, generalNotificationDetails);
    }
    if (days[6] == true) {
      fltrNotification.showWeeklyAtDayAndTime(
          6, title, body, Day.Sunday, notificationTime, generalNotificationDetails);
    }
  }

  Future _notificationSelected(String payload) async {}

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
            // textAlign: TextAlign.center,
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
                  .collection('SwipingQuestions')
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
                          Stack(alignment: AlignmentDirectional.topCenter, children: <Widget>[
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
                                          child: _buildDescriptionItem(snapshot.data.documents[i])),
                                      Expanded(child: _buildSlider(snapshot.data.documents[i])),
                                      Container(
                                        child: FloatingActionButton.extended(
                                            icon: Icon(Icons.navigate_next),
                                            label: Text('Next'),
                                            backgroundColor: Colors.lightGreen[700],
                                            onPressed: () {
                                              User newuser = UserProvider.of(context).user;
                                              answers['Question ${i + 1}'] = myFeedbackText;
                                              //TODO check Answer
                                              if (i == snapshot.data.documents.length - 1) {
                                                Future<void> _showEndDialog() async {
                                                  return showDialog<void>(
                                                    context: context,
                                                    barrierDismissible:
                                                        false, // user must tap button!
                                                    builder: (BuildContext context) {
                                                      return StatefulBuilder(
                                                          builder: (context, setState) {
                                                        return AlertDialog(
                                                          shape: RoundedRectangleBorder(),
                                                          title: Text(
                                                            'Attention',
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black,
                                                              fontFamily: 'Montserrat',
                                                              fontSize: 20.0,
                                                              letterSpacing: 2,
                                                            ),
                                                          ),
                                                          content: SingleChildScrollView(
                                                            child: ListBody(
                                                              children: <Widget>[
                                                                Text(
                                                                  'Questionnaire has been completely processed ',
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 12.0,
                                                                    letterSpacing: 2,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(
                                                                      left: 4.0),
                                                                  child: Text(
                                                                    'Reminder',
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.lightGreen,
                                                                      fontFamily: 'Montserrat',
                                                                      fontSize: 20.0,
                                                                      letterSpacing: 2,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Switch(
                                                                  activeColor: Colors.lightGreen,
                                                                  value: state,
                                                                  onChanged: (bool s) {
                                                                    setState(() {
                                                                      state = s;
                                                                    });
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                FlatButton(
                                                                  child: Text(
                                                                    'Set Time',
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.black54,
                                                                      fontFamily: 'Montserrat',
                                                                      fontSize: 15.0,
                                                                      letterSpacing: 2,
                                                                    ),
                                                                  ),
                                                                  onPressed: () async {
                                                                    var reminderData =
                                                                        await DBProvider.db
                                                                            .getRemind(
                                                                                newuser.email,
                                                                                widget.quename
                                                                                    .toUpperCase());
                                                                    if (reminderData ==
                                                                        'No '
                                                                            'Data available') {
                                                                      dateTimePicker =
                                                                          DateTime.now();
                                                                    } else {
                                                                      var reminderList =
                                                                          jsonDecode(reminderData);
                                                                      String date =
                                                                          reminderList["time"];
                                                                      print(date);
                                                                      DateTime newdate = DateFormat(
                                                                              "yyyy-MM-dd HH:mm:ss")
                                                                          .parse(date);

                                                                      /*List days = jsonDecode(
                                                                          reminderList[0]["days"]);*/

                                                                      dateTimePicker = newdate;
                                                                    }
                                                                    DatePicker.showTimePicker(
                                                                        context,
                                                                        showSecondsColumn: false,
                                                                        theme: DatePickerTheme(
                                                                          headerColor:
                                                                              Colors.lightGreen,
                                                                          itemStyle: TextStyle(
                                                                            color: Colors.black,
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            fontSize: 20.0,
                                                                            letterSpacing: 2,
                                                                          ),
                                                                          doneStyle: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.black,
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            fontSize: 20.0,
                                                                            letterSpacing: 2,
                                                                          ),
                                                                          cancelStyle: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.black,
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            fontSize: 20.0,
                                                                            letterSpacing: 2,
                                                                          ),
                                                                        ),
                                                                        showTitleActions: true,
                                                                        onChanged: (date) async {
                                                                      setState(() {
                                                                        dateTimePicker = date;
                                                                      });

                                                                      print('change $date');
                                                                    }, onConfirm: (date) {
                                                                      setState(() {
                                                                        dateTimePicker = date;
                                                                      });

                                                                      print('confirm $date');
                                                                    },
                                                                        currentTime: dateTimePicker,
                                                                        locale: LocaleType.en);
                                                                  },
                                                                ),
                                                                FlatButton(
                                                                  child: Text(
                                                                    'Set interval',
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.black54,
                                                                      fontFamily: 'Montserrat',
                                                                      fontSize: 15.0,
                                                                      letterSpacing: 2,
                                                                    ),
                                                                  ),
                                                                  onPressed: () async {
                                                                    var reminderDayData =
                                                                        await DBProvider.db
                                                                            .getRemindDay(
                                                                                newuser.email,
                                                                                widget.quename
                                                                                    .toUpperCase());
                                                                    if (reminderDayData ==
                                                                        'No '
                                                                            'Data available') {
                                                                      days = values;
                                                                    } else {
                                                                      var reminderList = jsonDecode(
                                                                          reminderDayData);

                                                                      days = reminderList["days"];
                                                                      print(days);

                                                                      /*List days = jsonDecode(
                                                                          reminderList[0]["days"]);*/

                                                                      //dateTimePicker = newdate;
                                                                    }
                                                                    showModalBottomSheet<void>(
                                                                      context: context,
                                                                      builder:
                                                                          (BuildContext context) {
                                                                        return StatefulBuilder(
                                                                            builder: (context,
                                                                                setState) {
                                                                          return Container(
                                                                            height: MediaQuery.of(
                                                                                        context)
                                                                                    .size
                                                                                    .width *
                                                                                2 /
                                                                                3,
                                                                            child: Column(
                                                                              children: [
                                                                                Container(
                                                                                  color: Colors
                                                                                      .lightGreen,
                                                                                  height: 40,
                                                                                  child: Row(
                                                                                    mainAxisAlignment:
                                                                                        MainAxisAlignment
                                                                                            .spaceBetween,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding:
                                                                                            const EdgeInsets.all(
                                                                                                5.0),
                                                                                        child:
                                                                                            FlatButton(
                                                                                          onPressed:
                                                                                              () {
                                                                                            Navigator.pop(
                                                                                                context);
                                                                                          },
                                                                                          child:
                                                                                              Text(
                                                                                            'Cancel',
                                                                                            style:
                                                                                                TextStyle(
                                                                                              fontWeight:
                                                                                                  FontWeight.bold,
                                                                                              color:
                                                                                                  Colors.black,
                                                                                              fontFamily:
                                                                                                  'Montserrat',
                                                                                              fontSize:
                                                                                                  20.0,
                                                                                              letterSpacing:
                                                                                                  2,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding:
                                                                                            const EdgeInsets.all(
                                                                                                5.0),
                                                                                        child:
                                                                                            FlatButton(
                                                                                          onPressed:
                                                                                              () {
                                                                                            Navigator.pop(
                                                                                                context);
                                                                                          },
                                                                                          child:
                                                                                              Text(
                                                                                            'Done',
                                                                                            style:
                                                                                                TextStyle(
                                                                                              fontWeight:
                                                                                                  FontWeight.bold,
                                                                                              color:
                                                                                                  Colors.black,
                                                                                              fontFamily:
                                                                                                  'Montserrat',
                                                                                              fontSize:
                                                                                                  20.0,
                                                                                              letterSpacing:
                                                                                                  2,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child:
                                                                                      WeekdaySelector(
                                                                                    selectedFillColor:
                                                                                        Colors
                                                                                            .lightGreen,
                                                                                    onChanged:
                                                                                        (int day) {
                                                                                      setState(() {
                                                                                        // Use module % 7 as Sunday's index in the array is 0 and
                                                                                        // DateTime.sunday constant integer value is 7.
                                                                                        final index =
                                                                                            day % 7;
                                                                                        // We "flip" the value in this example, but you may also
                                                                                        // perform validation, a DB write, an HTTP call or anything
                                                                                        // else before you actually flip the value,
                                                                                        // it's up to your app's needs.

                                                                                        days[index] =
                                                                                            !days[
                                                                                                index];
                                                                                      });
                                                                                    },
                                                                                    values: days,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        });
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                            FlatButton(
                                                              child: Text(
                                                                'Okay',
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.lightGreen,
                                                                  fontFamily: 'Montserrat',
                                                                  fontSize: 20.0,
                                                                  letterSpacing: 2,
                                                                ),
                                                              ),
                                                              onPressed: () async {
                                                                String str = DateFormat(
                                                                        "yyyy-MM-dd HH:mm:ss")
                                                                    .format(dateTimePicker);
                                                                Data data = Data(
                                                                    id: null,
                                                                    email: newuser.email,
                                                                    date: str,
                                                                    questionnaire: widget.quename
                                                                        .toUpperCase(),
                                                                    answers: jsonEncode(answers));
                                                                DBProvider.db
                                                                    .newQuestionnaire(data);

                                                                if (await DBProvider.db.getRemind(
                                                                        newuser.email,
                                                                        widget.quename
                                                                            .toUpperCase()) ==
                                                                    "No Data available") {
                                                                  DBProvider.db.newRemind(
                                                                      newuser.email,
                                                                      widget.quename.toUpperCase(),
                                                                      str,
                                                                      jsonEncode(values));
                                                                } else {
                                                                  DBProvider.db.changeRemind(
                                                                      str,
                                                                      newuser.email,
                                                                      widget.quename.toUpperCase());
                                                                }
                                                                _showNotification(dateTimePicker);

                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          UserProvider(
                                                                              user: newuser,
                                                                              child:
                                                                                  MyBottomNavigationBar(
                                                                                currentIndex: 0,
                                                                              ))),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                    },
                                                  );
                                                }

                                                _showEndDialog();
                                              } else {
                                                _pageController.nextPage(
                                                    duration: Duration(milliseconds: 300),
                                                    curve: Curves.easeIn);
                                                sliderValue = 4;
                                                myFeedbackText = "neutral";
                                              }
                                            }),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ))
                    ],
                  ),
                ));
              }),
        ));
  }

  Container _buildSlider(DocumentSnapshot document) {
    return Container(
        child: Align(
            child: Container(
                width: 350.0,
                height: 400.0,
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                        child: Text(
                      myFeedbackText,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontSize: 25.0,
                        // letterSpacing: 2,
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Slider(
                        min: 1.0,
                        max: 7.0,
                        divisions: 6,
                        value: sliderValue,
                        activeColor: Colors.lightGreen[700],
                        inactiveColor: Colors.grey,
                        onChanged: (newValue) {
                          setState(() {
                            sliderValue = newValue;
                            if (sliderValue >= 1.0 && sliderValue < 2.0) {
                              myFeedbackText = "strongly disagree";
                            }
                            if (sliderValue >= 2.0 && sliderValue < 3.0) {
                              myFeedbackText = "disagree";
                            }
                            if (sliderValue >= 3.0 && sliderValue <= 4.0) {
                              myFeedbackText = "neutral";
                            }
                            if (sliderValue >= 4.1 && sliderValue <= 5.0) {
                              myFeedbackText = "neutral";
                            }
                            if (sliderValue >= 5.1 && sliderValue <= 6.0) {
                              myFeedbackText = "agree";
                            }
                            if (sliderValue >= 6.1 && sliderValue <= 7.0) {
                              myFeedbackText = "strongly agree";
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                        child: Text(
                      "Your Rating: $sliderValue",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 25.0,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ]))));
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
