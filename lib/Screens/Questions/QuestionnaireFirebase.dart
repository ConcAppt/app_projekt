import 'package:flutter/material.dart';
import '../Questions/PageViewUpdate.dart';

enum Department { back, start }

class BuildOverview extends StatefulWidget {
  BuildOverview({Key key, this.index, this.document}) : super(key: key);
  final document;
  final index;
  @override
  _BuildOverviewState createState() => _BuildOverviewState();
}

class _BuildOverviewState extends State<BuildOverview> {
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
                    title: const Text('Show me the Results'),
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
                              child: const Text('Go'),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuildMyQuestionnaire()),
                );
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
                widget.document['questionnaireName'],
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 15),
              ),
              Spacer(flex: 8),
              Text(
                widget.document['questionnaireDescription'],
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Montserrat',
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              Spacer(flex: 8),
              Text(
                widget.document['questionnaireScope'],
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
