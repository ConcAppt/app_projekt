import 'package:appprojekt/Widgets/MyBottomNavigationBar.dart';
import 'package:appprojekt/data/Database.dart';
import 'package:appprojekt/models/user.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/thoma/AndroidStudioProjects/app_projekt/lib/Widgets/UserProvider_InWi.dart';

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: <Widget>[
          Text(UserProvider.of(context).user.name),
          Text(UserProvider.of(context).user.age.toString()),
          Text(UserProvider.of(context).user.email),
        ],
        ),
      ),
    );
  }
}
