import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Department { back, start }

class BuildMCEval extends StatefulWidget {
  BuildMCEval({Key key, this.quename}) : super(key: key);
  final quename;

  @override
  _BuildMCEvalState createState() => _BuildMCEvalState();
}

class _BuildMCEvalState extends State<BuildMCEval> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Text(widget.quename,
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.lightGreen[700],
                    letterSpacing: 2)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text('Here should be a graph',
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: 2)),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(icon: Icon(Icons.chevron_left, size: 30), onPressed: null),
                Text('Record x',
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        letterSpacing: 2)),
                IconButton(icon: Icon(Icons.chevron_right, size: 30), onPressed: null)
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('MultipleChoiceQuestions')
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
      subtitle: Text(
        (document['description']),
        style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Montserrat',
            letterSpacing: 1.5,
            fontWeight: FontWeight.w400,
            fontSize: 13),
      ),
      dense: true,
      isThreeLine: true,
    ),
  );
}
