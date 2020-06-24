import 'package:appprojekt/utils/Database.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _EvaluationPageState createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<ProfilePage> {
  Map<String, dynamic> newUser = {};
  Future _userFuture;

  @override
  void initState(){
    super.initState();
    _userFuture = getUser();
  }

  getUser() async{
    final _userData = await DBProvider.db.getUser();
    return _userData;
  }
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[700],
        title: Text(
              'Your Profile',
              style: TextStyle(
                color: Colors.grey[200],
                fontFamily: 'Montserrat',
                fontSize: 25.0)
        ),
      ),
      body: FutureBuilder(
          future: _userFuture,
          builder: (_, userData){
            switch (userData.connectionState){
              case ConnectionState.none:
                return Container();
              case ConnectionState.waiting:
                return Container();
              case ConnectionState.active:
              case ConnectionState.done:
                if (!newUser.containsKey('name')){
                  newUser = Map<String, dynamic>.from(userData.data);
                }

                return Column(children: <Widget>[
                  Text(newUser['name']),
                  Text(newUser['age'].toString()),
                  Text(newUser['email'])
                  ],
                );
            }
            return Container();
          }
          )
    );
  }
}
