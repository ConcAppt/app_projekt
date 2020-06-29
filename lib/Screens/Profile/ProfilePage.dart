import 'package:appprojekt/data/Database.dart';
import 'package:appprojekt/models/user.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({@required this.user});
  final User user;
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
      body: Column(children: <Widget>[
        Text(user.name),
        Text(user.age.toString()),
        Text(user.email)
      ],
      ),
    );
  }
}
