import 'package:flutter/material.dart';
import '../../Overview.dart';
import 'QuestionsWheel.dart';

enum Department { treasury, state }

class Questionnaire extends StatefulWidget {
  Questionnaire({Key key, this.questionnaireNumber}) : super(key: key);

  final questionnaireNumber;
  final List<Overview> overviewBank = [
    Overview(
        questionnaireName: 'MADSR',
        questionnaireDescription: 'Evaluating the severity of depression.',
        questionnaireUmfang: 'Length: 10 Questions'),
    Overview(
        questionnaireName: 'ERQ',
        questionnaireDescription: 'Examination of emotion regulation processes',
        questionnaireUmfang: 'Length: 10 Questions'),
    Overview(
        questionnaireName: 'Test1',
        questionnaireDescription: '-',
        questionnaireUmfang: 'Length: x Questions'),
    Overview(
        questionnaireName: 'Test2',
        questionnaireDescription: '-',
        questionnaireUmfang: 'Length: x Questions'),
    Overview(
        questionnaireName: 'Test3',
        questionnaireDescription: '-',
        questionnaireUmfang: 'Length: x Questions'),
    Overview(
        questionnaireName: 'Test4',
        questionnaireDescription: '-',
        questionnaireUmfang: 'Length: x Questions'),
  ];
  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
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
                                Navigator.pop(context, Department.treasury);
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
                                Navigator.pop(context, Department.state);
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
              case Department.treasury:
                //....
                break;
              case Department.state:
                QuestionWheel();
                break;
            }
          }

          openDialog();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)),
            color: Colors.lightGreen[600].withOpacity(0.7),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.overviewBank[widget.questionnaireNumber].name,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 15),
              ),
              Spacer(flex: 8),
              Text(
                widget.overviewBank[widget.questionnaireNumber].description,
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Monterrat',
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              Spacer(flex: 8),
              Text(
                widget.overviewBank[widget.questionnaireNumber].umfang,
                style: TextStyle(
                    color: Colors.black87, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*Overview o1 = Overview(
    questionnaireName: 'MADSR',
    questionnaireDescription:
        'Beschreibung: Ermittlung des Schweregrades einer Depression',
    questionnaireUmfang: 'Umfang: 10 Fragen');*/

/*
class Questionnaire extends Sta{
  int number;

  Questionnaire(int questionnaireNumber) {
    number = questionnaireNumber;
  }
}
*/
/*class Questionnaire extends StatelessWidget {
  Questionnaire({this.questionnaireNumber});

  final int questionnaireNumber;

  final List<Overview> overviewBank = [
    Overview(
        questionnaireName: 'MADSR',
        questionnaireDescription:
            'Beschreibung: Ermittlung des Schweregrades einer Depression',
        questionnaireUmfang: 'Umfang: 10 Fragen'),
    Overview(
        questionnaireName: 'ERQ',
        questionnaireDescription:
            'Beschreibung: Untersuchung von Emotionsregulationsprozessen',
        questionnaireUmfang: 'Umfang: 10 Fragen'),
    Overview(
        questionnaireName: 'Test1',
        questionnaireDescription: 'Beschreibung: -',
        questionnaireUmfang: 'Umfang: x Fragen'),
    Overview(
        questionnaireName: 'Test2',
        questionnaireDescription: 'Beschreibung: -',
        questionnaireUmfang: 'Umfang: x Fragen'),
    Overview(
        questionnaireName: 'Test3',
        questionnaireDescription: 'Beschreibung: -',
        questionnaireUmfang: 'Umfang: x Fragen'),
    Overview(
        questionnaireName: 'Test4',
        questionnaireDescription: 'Beschreibung: -',
        questionnaireUmfang: 'Umfang: x Fragen'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5)),
        color: Colors.blueGrey[600],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            overviewBank[questionnaireNumber].name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'NotoSans',
            ),
          ),
          Spacer(flex: 8),
          Text(
            overviewBank[questionnaireNumber].description,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'NotoSans',
            ),
          ),
          Spacer(flex: 8),
          Text(
            overviewBank[questionnaireNumber].umfang,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'NotoSans',
            ),
          )
        ],
      ),
    );
  }
}*/
