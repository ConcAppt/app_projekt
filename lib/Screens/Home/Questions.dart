import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPageViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Custom PageView',
      home: CustomPageViewScreen(),
    );
  }
}

class CustomPageViewScreen extends StatefulWidget {
  @override
  _CustomPageViewScreenState createState() => new _CustomPageViewScreenState();
}

class _CustomPageViewScreenState extends State<CustomPageViewScreen> {
  List questionsList = [
    QuestionModel(
        'Apparent Sadness',
        'Representing despondency, gloom and despair, (more than just ordinary transient low spirits) reflected in speech, facial expression, and posture.',
        'No sadness',
        'Looks miserable all the time. Extremely despondent.'),
    QuestionModel(
        'Reported sadness',
        'Representing reports of depressed mood, regardless of whether it is reflected in appearance  or not. Includes low spirits, despondency or the feeling of being beyond help and without hope.',
        'Occasional sadness in keeping with the circumstances.',
        'Continuous or unvarying sadness, misery or despondency.'),
    QuestionModel(
        'Inner tension',
        'Representing feelings of ill-defined discomfort, edginess, inner turmoil, mental tension mounting to either panic, dread or anguish.',
        'Placid. Only fleeting inner tension.',
        'Unrelenting dread or anguish. Overwhelming panic'),
    QuestionModel(
        'Reduced sleep',
        'Representing the experience of reduced duration or depth of sleep compared to the subject\'s own normal pattern when well.',
        'Sleeps as usual.',
        'Less than two or three hours sleep'),
    QuestionModel(
        'Reduced appetite',
        'Representing the feeling of a loss of appetite compared with when well.',
        'Normal or increased appetite.',
        'Needs persuasion to eat at all.'),
    QuestionModel(
        'Concentration Difficulties',
        'Representing difficulties in collecting one\'s thoughts mounting to incapacitating lack of concentration. Rate according to intensity, frequency, and degree of incapacity produced.',
        'No difficulties in concentrating.',
        'Unable to read or converse without great difficulty.'),
    QuestionModel(
        'Lassitude',
        'Representing a difficulty getting started or slowness initiating and performing everyday activities.',
        'Hardly any difficulty in getting started. No sluggishness.',
        'Complete lassitude. Unable to do anything without help.'),
    QuestionModel(
        'Inability to feel',
        'Representing the subjective experience of reduced interest in the surroundings, or activities that normally give pleasure. The ability to react with adequate emotion to circumstances or people is reduced.',
        'Normal interest in the surroundings and in other people',
        'The experience of being emotionally paralysed, inability to feel anger, grief or pleasure and a complete or even painful failure to feel for close relatives and friends.'),
    QuestionModel(
        'Pessimistic thoughts',
        'Representing thoughts of guilt, inferiority, self-reproach, sinfulness, remorse and ruin.',
        'No pessimistic thoughts.',
        'Delusions of ruin, remorse or unredeemable sin. Self-accusations which are absurd and unshakable.'),
    QuestionModel(
        'Suicidal thoughts',
        'Representing the feeling that life is not worth living, that a natural death would be welcome, suicidal thoughts, and preparations for suicide.',
        'Enjoys life or takes it as it comes.',
        'Explicit plans for suicide when there is an opportunity. Active preparation for suicide.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildTitle(),
              _buildInterestsContent(),
              //_buildSlider(),
              //_buildCheckIcon(),
              _buildNextButton()
            ],
          )),
    );
  }

  Text _buildTitle() {
    return Text(
      "MADSR".toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 23,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          color: Colors.lightGreen[700],
          letterSpacing: 2),
    );
  }

  Stack _buildInterestsContent() {
    return Stack(
      children: <Widget>[
        _buildInterestsPageView(),
      ],
    );
  }

  List ratingList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  PageController pageController = PageController();

  Container _buildInterestsPageView() {
    return Container(
      height: 400,
      child: PageView.builder(
        itemCount: questionsList.length,
        itemBuilder: (context, int currentIdx) {
          return Container(
            margin: const EdgeInsets.only(top: 0.0),
            child: Column(
              children: <Widget>[
                Flexible(child: _buildDescriptionItem(questionsList[currentIdx])),
                Flexible(
                    child: _buildAnswerItem(
                        questionsList[currentIdx], ratingList[currentIdx], currentIdx)),
              ],
            ),
          );
        },
        controller: pageController,
      ),
    );
  }

  Column _buildDescriptionItem(QuestionModel data) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(data.title.toUpperCase(),
                  style: TextStyle(
                    color: Colors.lightGreen[700],
                    fontFamily: 'Montserrat',
                    fontSize: 11.0,
                    letterSpacing: 2,
                  )),
              SizedBox(height: 7),
              Text(data.description,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontSize: 11.0,
                    letterSpacing: 2,
                  )),
            ],
          ),
        ),
        /* Expanded(
          child: Row(
            children: <Widget>[
              RotatedBox(
                quarterTurns: 1,
                child: Slider(
                  value: rating,
                  onChanged: (newRating) {
                    setState(() => rating = newRating);
                  },
                  activeColor: Colors.lightGreen[700],
                  inactiveColor: Colors.lightGreen[200],
                  min: 0,
                  max: 5,
                  divisions: 5,
                  label: "$rating",
                ),
              ),
              SizedBox(width: 30),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(data.bestCase,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 11.0,
                          letterSpacing: 2,
                        )),
                    Text(data.worstCase,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 11.0,
                          letterSpacing: 2,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),*/
      ],
    );
  }

  double rating;
  Column _buildAnswerItem(QuestionModel data, ratingL, currentIdx) {
    if (ratingList[currentIdx] == 0) {
      rating = 0;
    } else {
      rating = ratingList[currentIdx];
    }
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              RotatedBox(
                quarterTurns: 1,
                child: Slider(
                  value: rating,
                  onChanged: (newRating) {
                    setState(() {
                      rating = newRating;
                      ratingList[currentIdx] = newRating;
                    });
                  },
                  activeColor: Colors.lightGreen[700],
                  inactiveColor: Colors.lightGreen[200],
                  min: 0,
                  max: 6,
                  divisions: 6,
                  label: "$rating",
                ),
              ),
              SizedBox(width: 30),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(data.bestCase,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 11.0,
                          letterSpacing: 2,
                        )),
                    Text(data.worstCase,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 11.0,
                          letterSpacing: 2,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /*Container _buildCheckIcon() {
    String buttonAsset = selectedInterests.isEmpty
        ? 'assets/ic_check_gray.png'
        : 'assets/ic_check_yellow_rounded.png';
    return Container(
      child: Image.asset(buttonAsset),
    );
  }*/

  Container _buildNextButton() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 71, right: 71, top: 21),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: Center(
          child: Text(
            "Question".toUpperCase(),
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontSize: 19,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }

  /* //double rating = 0;
  Slider _buildSlider() {
    return Slider(
      value: rating,
      onChanged: (final newRating) {
        setState(() => rating = newRating);
      },
      activeColor: Colors.lightGreen[700],
      inactiveColor: Colors.lightGreen[200],
      min: 0,
      max: 5,
      divisions: 5,
      label: "$rating.toInt()",
    );
  }*/
}

/*Slider _buildSlider() {
  return Slider(
    value: rating,
    onChanged: (newRating) {
      setState(() => rating = newRating);
    },
    activeColor: Colors.lightGreen[700],
    inactiveColor: Colors.lightGreen[200],
    min: 0,
    max: 5,
    divisions: 5,
    label: "$rating",
  );
}*/

/*
class MySlider extends StatefulWidget {
  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double _startValue = 0;
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _startValue,
      onChanged: (final newRating) {
        setState(() => _startValue = newRating);
      },
      activeColor: Colors.lightGreen[700],
      inactiveColor: Colors.lightGreen[200],
      min: 0,
      max: 5,
      divisions: 5,
      label: "$_startValue",
    );
  }
}
*/

class QuestionModel {
  String title;
  String description;
  String bestCase;
  String worstCase;

  QuestionModel(this.title, this.description, this.bestCase, this.worstCase);
}
/*class InterestsModel extends StatefulWidget {
  InterestsModel({Key key, this.title, this.imageAsset}) : super(key: key);

  final String imageAsset;
  final String title;
  @override
  _InterestsModelState createState() => _InterestsModelState();
}

class _InterestsModelState extends State<InterestsModel> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/
