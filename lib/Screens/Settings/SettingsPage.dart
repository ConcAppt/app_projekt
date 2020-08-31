import 'package:appprojekt/Widgets/UserProvider_InWi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _EvaluationPageState createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0),
        child: AppBar(
          backgroundColor: Colors.lightGreen[400],
          automaticallyImplyLeading: false,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Hello ${UserProvider.of(context).user.name}!',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: Colors.lightGreen[700],
                            letterSpacing: 2)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Text('Here you can get more information about the App.',
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          letterSpacing: 2)),
                ),
                SizedBox(height: 15.0),
                Container(
                  height: 3.0,
                  color: Colors.lightGreen[400],
                ),
                SizedBox(height: 15.0),
                SizedBox.fromSize(child: BodyLayout(), size: Size(1000.0, 400.0)),
              ]),
        ),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  final titles = ['Terms of Use', 'Privacy Policy', 'Imprint', 'Help'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(
              titles[index],
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: 2),
            ),
          ),
        );
      },
    );
  }
}
