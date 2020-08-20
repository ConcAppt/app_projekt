import 'dart:convert';

import 'package:appprojekt/Widgets/UserProvider_InWi.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'dart:math';
import '../../data/Database.dart';

var recordArray = DBProvider();

enum Department { back, start }

class BuildSwipingEval extends StatefulWidget {
  BuildSwipingEval({Key key, this.quename}) : super(key: key);
  final quename;

  @override
  _BuildSwipingEvalState createState() => _BuildSwipingEvalState();
}

class _BuildSwipingEvalState extends State<BuildSwipingEval> {
  int _currentPage = 0;
  var record;
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

  Future<List> getRecord() async {
    List records = List();
    record = await jsonDecode(
        DBProvider.db.getRecords(UserProvider.of(context).user.email, widget.quename).toString());
    var json = jsonDecode(record);
    for (Map<String, dynamic> map in json) {
      records.add(record(map));
    }
    return records;

    /*await jsonDecode(
        DBProvider().getRecords(UserProvider.of(context).user.email, widget.quename).toString());*/
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
                print(record);
                Future<void> _showExportDialog() async {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                          scrollable: true,
                          shape: RoundedRectangleBorder(),
                          title: Text('Export your Files'),
                          content: Container(
                            height: 350,
                            width: double.maxFinite,
                            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                              Text('Please select the reports you want to send'),
                              SizedBox(height: 10.0),
                              Expanded(
                                child: FutureBuilder(
                                  builder: (context, AsyncSnapshot<List> snapshot) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return ListTile(
                                          onLongPress: () {
                                            setState(() {
                                              record[index].selected = !record[index].selected;

                                              log(record[index].selected);
                                            });
                                          },
                                          selected: record[index].selected,
                                          leading: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {},
                                          ),
                                          title: Text('Record ' + record[index].toString()),
                                          subtitle: Text('Datum'),
                                          trailing: (record[index].selected)
                                              ? Icon(Icons.check_box)
                                              : Icon(Icons.check_box_outline_blank),
                                        );
                                      },
                                    );
                                  },
                                  future: getRecord(),
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
                              alignment: MainAxisAlignment.spaceAround,
                            ),
                          ]);
                    },
                  );
                }

                _showExportDialog();
              }),
        ],
      ),
      // backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text('Here should be a graph',
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    letterSpacing: 2)),
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
                        _pageController.animateToPage(0,
                            duration: Duration(milliseconds: 200), curve: Curves.easeIn);
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
                        _pageController.animateToPage(3,
                            duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                      }),
                ),
              ],
            ),
          ),
          Center(
            child: Text('${_currentPage + 1} of lengthArray',
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
                itemCount: 3,
                itemBuilder: (ctx, i) {
                  return StreamBuilder(
                      stream: Firestore.instance
                          .collection('SwipingQuestions')
                          .document(widget.quename)
                          .collection("Questions")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const CircularProgressIndicator();
                        return ListView.separated(
                          padding: const EdgeInsets.all(8),
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildListTile(context, snapshot.data.documents[index], index);
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(),
                        );
                      });
                }),
          ),
        ],
      )),
    );
  }
}

Widget _buildListTile(BuildContext context, DocumentSnapshot document, index) {
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
              text: ' answer',
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
