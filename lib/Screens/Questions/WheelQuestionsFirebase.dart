import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Widgets/MyBottomNavigationBar.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../Widgets/UserProvider_InWi.dart';
import '../../models/user.dart';

class BuildWheelQuestionnaire extends StatefulWidget {
  BuildWheelQuestionnaire({Key key, this.quename}) : super(key: key);
  final quename;
  @override
  _BuildWheelQuestionnaireState createState() => new _BuildWheelQuestionnaireState();
}

class _BuildWheelQuestionnaireState extends State<BuildWheelQuestionnaire> {
  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);
  var myFeedbackText = 'neutral';
  var sliderValue = 4.0;
  int selectedCard;
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
                  .collection("WheelQuestionnaires")
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
                                      Expanded(child: _listViewListTile(snapshot.data.documents[i])),
                                      Container(
                                        child: FloatingActionButton.extended(
                                            icon: Icon(Icons.navigate_next),
                                            label: Text('Next'),
                                            backgroundColor: Colors.lightGreen[700],
                                            onPressed: () {
                                              User newuser = UserProvider.of(context).user;
                                              //TODO check Answer
                                              Future<void> _showMyDialog() async {
                                                return showDialog<void>(
                                                  context: context,
                                                  barrierDismissible: false, // user must tap button!
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      shape: RoundedRectangleBorder(),
                                                      title: Text('Attention'),
                                                      content: SingleChildScrollView(
                                                        child: ListBody(
                                                          children: <Widget>[
                                                            Text('Please select an answer option'),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: <Widget>[
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
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }

                                              if (selectedCard == null) {
                                                _showMyDialog();
                                              } else {
                                                if (i == snapshot.data.documents.length - 1) {
                                                  Future<void> _showEndDialog() async {
                                                    return showDialog<void>(
                                                      context: context,
                                                      barrierDismissible:
                                                          false, // user must tap button!
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          shape: RoundedRectangleBorder(),
                                                          title: Text('Attention'),
                                                          content: SingleChildScrollView(
                                                            child: ListBody(
                                                              children: <Widget>[
                                                                Text(
                                                                    'Questionnaire has been completely processed '),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: <Widget>[
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
                                                              onPressed: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          UserProvider(user: newuser, child: MyBottomNavigationBar())),
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
                                                      duration: Duration(milliseconds: 300),
                                                      curve: Curves.easeIn);
                                                  selectedCard = null;
                                                }
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

  ListView _listViewListTile(DocumentSnapshot document) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: document['answers'].length,
      itemBuilder: (context, i) {
        List answers = document['answers'];
        double interpolation = 1 / (answers.length);

        Color color = Color.lerp(Colors.green, Colors.red, i * interpolation);

        return Card(
          color: (selectedCard == i) ? Colors.grey[300] : null,
          child: ListTile(
            title: Center(
              child: Text(
                answers[i],
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  letterSpacing: 2,
                ),
              ),
            ),
            onTap: () {
              setState(() {
                if (selectedCard == i) {
                  selectedCard = null;
                } else {
                  selectedCard = i;
                }
              });
              print('Card tapped $i');
            },
          ),
        );
      },
      separatorBuilder: (context, i) => const SizedBox(
        height: 10,
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
