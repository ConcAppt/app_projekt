import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuildMyQuestionnaire extends StatefulWidget {
  @override
  _BuildMyQuestionnaireState createState() => _BuildMyQuestionnaireState();
}

class _BuildMyQuestionnaireState extends State<BuildMyQuestionnaire> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
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

  List questionsList = [
    QuestionModel(
        'Apparent Sadness',
        'Representing despondency, gloom and despair, (more than just ordinary transient low spirits) reflected in speech, facial expression, and posture.',
        '0 No sadness',
        '2 Looks dispirited but does brighten up without difficulty',
        '4 Appears sad and unhappy most of the time.',
        '6 Looks miserable all the time. Extremely despondent.'),
    QuestionModel(
        'Reported sadness',
        'Representing reports of depressed mood, regardless of whether it is reflected in appearance  or not. Includes low spirits, despondency or the feeling of being beyond help and without hope.',
        '0 Occasional sadness in keeping with the circumstances.',
        '2 Sad or low but brightens up without difficulty.',
        '4 Pervasive feelings of sadness or gloominess. The mood is still influenced by external circumstances.',
        '6 Continuous or unvarying sadness, misery or despondency.'),
    QuestionModel(
        'Inner tension',
        'Representing feelings of ill-defined discomfort, edginess, inner turmoil, mental tension mounting to either panic, dread or anguish.',
        '0 Placid. Only fleeting inner tension.',
        '2 Occasional feelings of edginess and ill defined discomfort',
        '4 Continuous feelings of inner tension or intermittent panic which the patient can only '
            'master with some difficulty.',
        '6 Unrelenting dread or anguish. Overwhelming panic'),
    QuestionModel(
        'Reduced sleep',
        'Representing the experience of reduced duration or depth of sleep compared to the subject\'s own normal pattern when well.',
        '0 Sleeps as usual.',
        '2 Slight difficulty dropping off to sleep or slightly reduced, light or fitful sleep.',
        '4 Sleep reduced or broken by at least two hours.',
        '6 Less than two or three hours sleep'),
    QuestionModel(
        'Reduced appetite',
        'Representing the feeling of a loss of appetite compared with when well.',
        '0 Normal or increased appetite.',
        '2 Slightly reduced appetite.',
        '4 No appetite. Food is tasteless.',
        '6 Needs persuasion to eat at all.'),
    QuestionModel(
        'Concentration Difficulties',
        'Representing difficulties in collecting one\'s thoughts mounting to incapacitating lack of concentration. Rate according to intensity, frequency, and degree of incapacity produced.',
        '0 No difficulties in concentrating.',
        '2 Occasional difficulties in collecting one\'s thoughts.',
        '4 Difficulties in concentrating and sustaining thought which reduces ability to read or '
            'hold a conversation.',
        '6 Unable to read or converse without great difficulty.'),
    QuestionModel(
        'Lassitude',
        'Representing a difficulty getting started or slowness initiating and performing everyday activities.',
        '0 Hardly any difficulty in getting started. No sluggishness.',
        '2 Difficulties in starting activities.',
        '4 Difficulties in starting simple routine activities which are carried out with effort.',
        '6 Complete lassitude. Unable to do anything without help.'),
    QuestionModel(
        'Inability to feel',
        'Representing the subjective experience of reduced interest in the surroundings, or activities that normally give pleasure. The ability to react with adequate emotion to circumstances or people is reduced.',
        '0 Normal interest in the surroundings and in other people',
        '2 Reduced ability to enjoy usual interests.',
        '4 Loss of interest in the surroundings. Loss of feelings or friends and acquaintances.',
        '6 The experience of being emotionally paralysed, inability to feel anger, grief or '
            'pleasure and a complete or even painful failure to feel for close relatives and friends.'),
    QuestionModel(
        'Pessimistic thoughts',
        'Representing thoughts of guilt, inferiority, self-reproach, sinfulness, remorse and ruin.',
        '0 No pessimistic thoughts.',
        '2 Fluctuating ideas of failure, self-reproach or self depreciation.',
        '4 Persistent self-accusations, or definite but still rational ideas of guilt or sin. '
            'Increasingly pessimistic about the future.',
        '6 Delusions of ruin, remorse or unredeemable sin. Self-accusations which are absurd and '
            'unshakable.'),
    QuestionModel(
        'Suicidal thoughts',
        'Representing the feeling that life is not worth living, that a natural death would be welcome, suicidal thoughts, and preparations for suicide.',
        '0 Enjoys life or takes it as it comes.',
        '2 Weary of life. Only fleeting suicidal thoughts.',
        '4 Probably better off dead. Suicidal thoughts are common, and suicide is considered as a'
            ' possible solution, but without specific plans or intention.',
        '6 Explicit plans for suicide when there is an opportunity. Active preparation for suicide'
            '.'),
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
                            for (int i = 0; i < questionsList.length; i++)
                              if (i == _currentPage) SlideDots(true) else SlideDots(false)
                          ],
                        ),
                      )
                    ]),
                    PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        itemCount: questionsList.length,
                        itemBuilder: (ctx, i) {
                          return Container(
                            margin: const EdgeInsets.only(top: 0.0),
                            child: Column(
                              children: <Widget>[
                                Expanded(child: _buildDescriptionItem(questionsList[i])),
                                Flexible(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                                  child: _buildListWheel(questionsList[i]),
                                )),
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

  ListWheelScrollView _buildListWheel(QuestionModel data) {
    return ListWheelScrollView(itemExtent: 100, squeeze: 0.9, clipToSize: false, children: [
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
  }

  Container _buildDescriptionItem(QuestionModel data) {
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

class QuestionModel {
  String title;
  String description;
  String zeroCase;
  String twoCase;
  String fourCase;
  String sixCase;

  QuestionModel(
      this.title, this.description, this.zeroCase, this.twoCase, this.fourCase, this.sixCase);
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
