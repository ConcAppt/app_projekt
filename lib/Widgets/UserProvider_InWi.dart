import 'package:appprojekt/data/Database.dart';
import 'package:flutter/material.dart';
import 'package:appprojekt/models/user.dart';

class UserProvider extends InheritedWidget{
  UserProvider({Key key, Widget child, @required this.user}) : super(key: key, child: child);
  final User user;

  static UserProvider of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<UserProvider>();
  }

  @override
  bool updateShouldNotify(UserProvider old) =>
      true;
      //user != old.user;
}

