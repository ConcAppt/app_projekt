import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuildSwipingQuestionnaire extends StatefulWidget {
  BuildSwipingQuestionnaire({Key key, this.name}) : super(key: key);
  final name;
  @override
  _BuildSwipingQuestionnaireState createState() => _BuildSwipingQuestionnaireState();
}

class _BuildSwipingQuestionnaireState extends State<BuildSwipingQuestionnaire> {
  int _currentPage = 0;
  double _sumValue = 0;

  final PageController _pageController = PageController(initialPage: 0);
  var myFeedbackText = 'neutral';
  var sliderValue = 4.0;
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
            widget.name.toUpperCase(),
            // textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: Colors.lightGreen[700],
                letterSpacing: 2),
          ),
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('SwipingQuestions')
                .document(widget.name)
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
                          Container(
                            margin: const EdgeInsets.only(bottom: 35),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                for (int i = 0; i < snapshot.data.documents.length; i++)
                                  if (i == _currentPage) SlideDots(true) else SlideDots(false)
                              ],
                            ),
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
                                            //TODO check Answer
                                            if (i == snapshot.data.documents.length - 1) {
                                              _pageController.jumpToPage(0);
                                            } else {
                                              _pageController.nextPage(
                                                  duration: Duration(milliseconds: 300),
                                                  curve: Curves.easeIn);

                                              _sumValue = _sumValue + sliderValue;
                                              print(_sumValue);
                                              //DateTime now = DateTime.now();
                                              //String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
                                              sliderValue = 4;
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
            }));
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
                          /*_sumValue = _sumValue + sliderValue;
                          print(_sumValue);*/
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

/*class QuestionModelScale {
  String title;
  String description;

  QuestionModelScale(this.title, this.description);
}*/

class SlideDots extends StatelessWidget {
  bool isActive;

  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.lightGreen[700] : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
