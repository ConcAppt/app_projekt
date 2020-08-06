import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuestionWheel extends StatelessWidget {
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
      body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_buildTitle(), _buildInterestsContent(), _buildNextButton()],
          )),
    );
  }

  AppBar _buildTitle() {
    return AppBar(
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
    );
  }
/*int currentPage=0;
  Stack _buildSlideDots() {
    Stack(
      alignment: AlignmentDirectional.topStart,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 35),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < questionsList.length; i++)
                if (i == currentPage) SlideDots(true) else SlideDots(false)
            ],
          ),
        ),
      ],
    );
  }*/

  Stack _buildInterestsContent() {
    return Stack(
      children: <Widget>[
        _buildInterestsPageView(),
      ],
    );
  }

  List ratingList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  PageController pageController = PageController(initialPage: 0);

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
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: _buildListWheel(questionsList[currentIdx]),
                )),
              ],
            ),
          );
        },
        controller: pageController,
      ),
    );
  }

  int _selectedItemIndex = 0;
  ListWheelScrollView _buildListWheel(QuestionModel data) {
    return ListWheelScrollView(
        itemExtent: 100,
        squeeze: 0.9,
        clipToSize: false,
        onSelectedItemChanged: (index) => {
              setState(() {
                _selectedItemIndex = index;
                print(_selectedItemIndex);
              })
            },
        children: [
          Card(
            color: Colors.grey.withOpacity(0.1),
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
          Card(
            child: InkWell(
              splashColor: Colors.lightGreen,
              onTap: () {
                print('Card tapped');
              },
              child: Center(
                child: Text(
                  '1',
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 20.0,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
          Card(
            child: Center(
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
          ),
          Card(
            child: Center(
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
          ),
          Card(
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
          Card(
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
          Card(
            child: Center(
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
          ),
        ]);
  }

  ListView _listView(QuestionModel data) {
    return ListView.builder(itemBuilder: (context, i) {
      return Card(
        child: InkWell(
          splashColor: Colors.lightGreen,
          onTap: () {
            print('Card tapped');
          },
          child: Center(
            child: Text(
              'bla',
              style: TextStyle(
                color: Colors.lightGreen,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                fontSize: 20.0,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      );
    });
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
      ],
    );
  }

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
        color: isActive ? Theme.of(context).primaryColor : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
