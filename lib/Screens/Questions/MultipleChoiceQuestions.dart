import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuildMyQuestionnaire extends StatefulWidget {
  @override
  _BuildMyQuestionnaireState createState() => _BuildMyQuestionnaireState();
}

class _BuildMyQuestionnaireState extends State<BuildMyQuestionnaire> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  var myFeedbackText = 'neutral';
  var sliderValue = 4.0;
  bool _isSelected = false;
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

  List emQueQuestions = [
    QuestionModelChoice('Question 1', 'When another child cries, my child gets upset too.'),
    QuestionModelChoice('Question 2',
        'When I make clear that I want some peace and quiet, my child tries not to bother me. '),
    QuestionModelChoice(
        'Question 3', 'When my child sees other children laughing, he/she starts laughing too.'),
    QuestionModelChoice(
        'Question 4', 'My child also needs to becomforted when another child is in pain. '),
    QuestionModelChoice(
        'Question 5', 'When another child starts to cry, my child tries to comfort him/her.'),
    QuestionModelChoice('Question 6',
        'When an adult gets angry with another child, my child watches attentively. '),
    QuestionModelChoice('Question 7',
        'When another child makes a bad fall, shortly after my child pretends to fall too.'),
    QuestionModelChoice(
        'Question 8', 'When another child gets upset, my child tries to cheer him/her up.'),
    QuestionModelChoice('Question 9', 'My child looks up when another child laughs.'),
    QuestionModelChoice(
        'Question 10', 'When another child is upset, my child needs to be comforted too. '),
    QuestionModelChoice('Question 11',
        'When I make clear that I want to do something by myself (e.g. read), my child leaves me alone for a while. '),
    QuestionModelChoice('Question 12', 'When adults laugh, my child tries to get near them.'),
    QuestionModelChoice(
        'Question 13', 'When another child gets frightened, my child freezes or starts to cry.'),
    QuestionModelChoice(
        'Question 14', 'When two children are quarrelling, my child tries to stop them. '),
    QuestionModelChoice('Question 15', 'My child looks up when another child cries. '),
    QuestionModelChoice('Question 16', 'When other children argue, my child gets upset. '),
    QuestionModelChoice(
        'Question 17', 'When another child gets frightened, my child tries to help him/her. '),
    QuestionModelChoice(
        'Question 18', 'When another child is angry, my child stops his own play to watch. '),
    QuestionModelChoice('Question 19', 'When another child cries, my child looks away. '),
    QuestionModelChoice(
        'Question 20', 'When other children quarrel, my child wants to see what is going on.'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "MADSR".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: Colors.lightGreen[700],
                  letterSpacing: 2),
            ),
          ),
        ),
        body: Container(
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
                            for (int i = 0; i < emQueQuestions.length; i++)
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
                        itemCount: emQueQuestions.length,
                        itemBuilder: (ctx, i) {
                          return Container(
                            margin: const EdgeInsets.only(top: 0.0),
                            child: Column(
                              children: <Widget>[
                                Expanded(child: _buildDescriptionItem(emQueQuestions[i])),
                                Expanded(child: _buildSlider(emQueQuestions[i])),
                                Container(
                                  child: FloatingActionButton.extended(
                                      icon: Icon(Icons.navigate_next),
                                      label: Text('Next'),
                                      backgroundColor: Colors.lightGreen[700],
                                      onPressed: () {
                                        //TODO check Answer
                                        if (i == emQueQuestions.length - 1) {
                                          _pageController.jumpToPage(0);
                                        } else {
                                          _pageController.nextPage(
                                              duration: Duration(milliseconds: 300),
                                              curve: Curves.easeIn);

                                          sliderValue = 4;
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
        )));
  }

  /*ListWheelScrollView _buildListWheel(QuestionModelScale data) {
    return ListWheelScrollView(
        itemExtent: 100,
        squeeze: 0.9,
        //useMagnifier: true,
        diameterRatio: 6,
        children: [
          Container(
            child: Center(
              child: Text(
                data.zeroCase,
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              '1',
              style: TextStyle(
                color: Colors.lightGreen,
                fontFamily: 'Montserrat',
                fontSize: 20.0,
                letterSpacing: 2,
              ),
            ),
          ),
          Container(
            height: 20,
            child: Text(
              data.twoCase,
              style: TextStyle(
                color: Colors.lime,
                fontFamily: 'Montserrat',
                fontSize: 20.0,
                letterSpacing: 2,
              ),
            ),
          ),
          Container(
            height: 20,
            child: Text(
              '3',
              style: TextStyle(
                color: Colors.yellow,
                fontFamily: 'Montserrat',
                fontSize: 20.0,
                letterSpacing: 2,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 20,
            child: Center(
              child: Text(
                data.fourCase,
                //overflow: TextOverflow.visible,
                style: TextStyle(
                  color: Colors.amber,
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          Container(
            height: 20,
            child: Center(
              child: Text(
                '5',
                style: TextStyle(
                  color: Colors.orange,
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          Container(
            height: 20,
            child: Text(
              data.sixCase,
              style: TextStyle(
                color: Colors.deepOrange,
                fontFamily: 'Montserrat',
                fontSize: 20.0,
                letterSpacing: 2,
              ),
            ),
          ),
        ]);
  }*/

  Container _buildCheckBoxList(QuestionModelChoice data) {
    return Container(
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            title: Text(data.no),
            value: _isSelected,
            onChanged: (bool newValue) {
              setState(() {
                _isSelected = newValue;
              });
            },
          )
        ],
      ),
    );
  }

  Container _buildSlider(QuestionModelChoice data) {
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
                            if (sliderValue >= 1.0 && sliderValue <= 2.0) {
                              myFeedbackText = "strongly disagree";
                            }
                            if (sliderValue >= 2.1 && sliderValue <= 3.0) {
                              myFeedbackText = "disagree";
                            }
                            if (sliderValue >= 3.1 && sliderValue <= 4.0) {
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

  Container _buildDescriptionItem(QuestionModelChoice data) {
    return Container(
      height: 10,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(data.title.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen[700],
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                letterSpacing: 2,
              )),
          SizedBox(height: 7),
          Text(data.description,
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

class QuestionModelChoice {
  String title;
  String description;
  String no = 'Not at all applicable';
  String sometimes = 'A little or sometimes applicable';
  String often = 'Clearly or often applicable';

  String nottrue = 'not true';
  String sometimesTrue = 'sometimes true';
  String ttrue = 'true';

  QuestionModelChoice(this.title, this.description);
}

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
