import 'dart:convert';
import 'package:appprojekt/Widgets/UserProvider_InWi.dart';
import 'package:appprojekt/data/Database.dart';
import 'package:appprojekt/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'ExcelCreator.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

enum Department { back, start }

class BuildMCEval extends StatefulWidget {
  BuildMCEval({Key key, this.quename}) : super(key: key);
  final quename;

  @override
  _BuildMCEvalState createState() => _BuildMCEvalState();
}

class _BuildMCEvalState extends State<BuildMCEval> {
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
        actions: [
          IconButton(
              icon: Icon(Icons.share, size: 30),
              onPressed: () {
                User user = UserProvider.of(context).user;

                Future<void> _showExportDialog() async {
                  var data = await DBProvider.db.getRecords(
                      UserProvider.of(context).user.email, widget.quename.toUpperCase());
                  var datumExcl = await DBProvider.db.getDate(UserProvider.of(context).user.email,
                      widget.quename.toUpperCase(), _currentPage);
                  var values = await DBProvider.db.getValues(UserProvider.of(context).user.email,
                      widget.quename.toUpperCase(), _currentPage);
                  var list = jsonDecode(data);
                  int value = list[0]["count(id)"];
                  var array = List.filled(value, false);
                  final checkArray = List.filled(value, false);
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return AlertDialog(
                            scrollable: true,
                            shape: RoundedRectangleBorder(),
                            title: Text(
                              'Export your Files',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontSize: 20.0,
                                letterSpacing: 2,
                              ),
                            ),
                            content: Container(
                              height: 350,
                              width: double.minPositive,
                              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                                Text(
                                  'Please select the reports you want to send',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontSize: 12.0,
                                    letterSpacing: 2,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: array.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return FutureBuilder(
                                          future: DBProvider.db.getDate(
                                              user.email, widget.quename.toUpperCase(), index),
                                          builder: (context, AsyncSnapshot<dynamic> dat) {
                                            if (!dat.hasData) {
                                              return CircularProgressIndicator();
                                            }
                                            return CheckboxListTile(
                                              activeColor: Colors.lightGreen,
                                              value: array[index],
                                              title: Text(
                                                'Report '
                                                '${index + 1}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 15.0,
                                                  letterSpacing: 2,
                                                ),
                                              ),
                                              subtitle: Text(
                                                dat.data,
                                                style: TextStyle(
                                                  color: Colors.black38,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 10.0,
                                                  letterSpacing: 2,
                                                ),
                                              ),
                                              onChanged: (val) {
                                                setState(() {
                                                  array[index] = val;
                                                });
                                              },
                                            );
                                          });
                                    },
                                  ),
                                )
                              ]),
                            ),
                            actions: <Widget>[
                              ButtonBar(
                                children: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      'Back',
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
                                  StreamBuilder(
                                      stream: Firestore.instance
                                          .collection('MultipleChoiceQuestions')
                                          .document(widget.quename)
                                          .collection("Questions")
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.data == null) {
                                          return CircularProgressIndicator();
                                        } else {
                                          List docList = snapshot.data.documents;

                                          return FlatButton(
                                            child: Text(
                                              'Export',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.lightGreen,
                                                fontFamily: 'Montserrat',
                                                fontSize: 20.0,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                            onPressed: () async {
                                              if (listEquals(array, checkArray) == false) {
                                                Future<void> _shareFiles() async {
                                                  try {
                                                    String path = await localPath;
                                                    var file = join(path, 'exportfile.xlsx');
                                                    final ByteData bytes1 = File(file)
                                                        .readAsBytesSync()
                                                        .buffer
                                                        .asByteData();

                                                    await Share.files(
                                                        'File from our app',
                                                        {
                                                          'exportfile.xlsx':
                                                              bytes1.buffer.asUint8List(),
                                                        },
                                                        '*/*',
                                                        text:
                                                            'Hello, in the attachment are the reports I would like to share with you');
                                                  } catch (e) {
                                                    print('error: $e');
                                                  }
                                                }

                                                await createExportFile(context, user, docList,
                                                    values, widget.quename, datumExcl, array);
                                                Future<void> openFile() async {
                                                  String path = await localPath;
                                                  var file = join(path, 'exportfile.xlsx');
                                                  var bytes = File(file).readAsBytesSync();
                                                  var excel = Excel.decodeBytes(bytes);

                                                  for (var table in excel.tables.keys) {
                                                    print(table); //sheet Name
                                                    print(excel.tables[table].maxCols);
                                                    print(excel.tables[table].maxRows);
                                                    for (var row in excel.tables[table].rows) {
                                                      print("$row");
                                                    }
                                                  }
                                                }

                                                openFile();
                                                _shareFiles();
                                              } else {
                                                Future<void> _showSelectDialog() async {
                                                  return showDialog<void>(
                                                    context: context,
                                                    barrierDismissible:
                                                        false, // user must tap button!
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
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
                                                          child: Text(
                                                            'Please select some Reports you '
                                                            'want to share',
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontFamily: 'Montserrat',
                                                              fontSize: 12.0,
                                                              letterSpacing: 2,
                                                            ),
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

                                                _showSelectDialog();
                                              }
                                            },
                                          );
                                        }
                                      }),
                                ],
                                alignment: MainAxisAlignment.spaceAround,
                              ),
                            ]);
                      });
                    },
                  );
                }

                _showExportDialog();
              }),
        ],
      ),
      // backgroundColor: Colors.white,
      body: FutureBuilder(
          future: DBProvider.db
              .getRecords(UserProvider.of(context).user.email, widget.quename.toUpperCase()),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
            if (!snap.hasData) {
              return Text('No Data available');
            }
            var list = jsonDecode(snap.data);
            int value = list[0]["count(id)"];
            return SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: FutureBuilder(
                      future: DBProvider.db.getDate(UserProvider.of(context).user.email,
                          widget.quename.toUpperCase(), _currentPage),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> ap) {
                        if (!ap.hasData) {
                          return Text('No data available',
                              style: TextStyle(
                                  fontSize: 23,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  letterSpacing: 2));
                        }
                        return Text(ap.data,
                            style: TextStyle(
                                fontSize: 23,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                                letterSpacing: 2));
                      }),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Transform.rotate(
                        angle: 3 * pi / 2,
                        child: IconButton(
                            icon: Icon(Icons.keyboard_capslock, size: 30),
                            onPressed: () {
                              _pageController.jumpToPage(0);
                            }),
                      ),
                      IconButton(
                          icon: Icon(Icons.chevron_left, size: 30),
                          onPressed: () {
                            _pageController.previousPage(
                                duration: Duration(milliseconds: 400), curve: Curves.easeIn);
                          }),
                      Text('Record ${_currentPage + 1}',
                          style: TextStyle(
                              fontSize: 23,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              letterSpacing: 2)),
                      IconButton(
                          icon: Icon(Icons.chevron_right, size: 30),
                          onPressed: () {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 400), curve: Curves.easeIn);
                          }),
                      Transform.rotate(
                        angle: pi / 2,
                        child: IconButton(
                            icon: Icon(Icons.keyboard_capslock, size: 30),
                            onPressed: () {
                              _pageController.jumpToPage(value);
                            }),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text('${_currentPage + 1} of $value',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          letterSpacing: 2)),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: PageView.builder(
                      physics: new NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: value,
                      itemBuilder: (ctx, i) {
                        return StreamBuilder(
                            stream: Firestore.instance
                                .collection('MultipleChoiceQuestions')
                                .document(widget.quename)
                                .collection("Questions")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return const CircularProgressIndicator();
                              return FutureBuilder(
                                  future: DBProvider.db.getValues(
                                      UserProvider.of(context).user.email,
                                      widget.quename.toUpperCase(),
                                      _currentPage),
                                  builder: (BuildContext context, AsyncSnapshot<dynamic> nap) {
                                    if (!nap.hasData) {
                                      return Text('No Data available');
                                    }
                                    return ListView.separated(
                                      padding: const EdgeInsets.all(8),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.documents.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return _buildListTile(context,
                                            snapshot.data.documents[index], index, nap.data);
                                      },
                                      separatorBuilder: (BuildContext context, int index) =>
                                          const Divider(),
                                    );
                                  });
                            });
                      }),
                ),
              ],
            ));
          }),
    );
  }
}

Widget _buildListTile(BuildContext context, DocumentSnapshot document, index, Map map) {
  index = index + 1;
  return Card(
    color: Colors.lightGreen[600].withOpacity(0.7),
    child: ListTile(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
        child: Text(
          'Question $index',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              fontSize: 15),
        ),
      ),
      subtitle: RichText(
        text: TextSpan(
          text: document['description'],
          style: TextStyle(
              color: Colors.black87,
              fontFamily: 'Montserrat',
              letterSpacing: 1.5,
              fontWeight: FontWeight.w400,
              fontSize: 13),
          children: <TextSpan>[
            TextSpan(
              text: '\n\n' + 'Selected answer:',
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Montserrat',
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w400,
                  fontSize: 13),
            ),
            TextSpan(
              text: ' ${map["Question $index"]}',
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Montserrat',
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ],
        ),
      ),
      dense: true,
      isThreeLine: true,
    ),
  );
}
