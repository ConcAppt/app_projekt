import 'package:appprojekt/Widgets/MyBottomNavigationBar.dart';
import 'package:appprojekt/Widgets/UserProvider_InWi.dart';
import 'package:appprojekt/data/Database.dart';
import 'package:appprojekt/models/user.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  CustomDialog(this.value, this.user);

  final value;
  final user;

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  int _age;
  String _mail;
  String _password;

  String _oldname;
  String _oldage;
  String _oldemail;
  String _oldpassword;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, widget.value, widget.user),
    );
  }

  dialogContent(context, String value, User user) {
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(30.0),
            decoration:
                new BoxDecoration(color: Colors.white, shape: BoxShape.rectangle, boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              )
            ]),
            child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(mainAxisSize: MainAxisSize.min, // To make the card compact
                    children: <Widget>[
                      Text(
                        'Change your $value',
                        style: TextStyle(
                          color: Colors.lightGreen[700],
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      getText(value, user),
                    ]))),
      ],
    );
  }

  getText(String value, User user) {
    if (value == 'name') {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter your new name',
              ),
              style: TextStyle(fontSize: 20.0),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your name';
                }
                if (value == user.name) {
                  return 'Nothing changed';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            SizedBox(height: 24.0),
            Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      if (true && (user.name != _name)) {
                        print(_name);
                        await DBProvider.db.changeName(_name, user.email, user.password);
                        User newuser = await DBProvider.db.loginUser(user.email, user.password);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProvider(
                                  user: newuser,
                                  child: MyBottomNavigationBar(
                                    currentIndex: 2,
                                  ))),
                        );
                      }
                      // Process data
                      return null;
                    }
                  },
                  child: Text(
                    'submit',
                    style: TextStyle(color: Colors.lightGreen[700], fontSize: 25.0),
                  ),
                ))
          ],
        ),
      );
    }

    if (value == 'age') {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter your new age',
              ),
              style: TextStyle(fontSize: 20.0),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your age';
                }
                if (int.tryParse(value) == user.age) {
                  return 'Nothing changed';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _age = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 24.0),
            Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      if (true && (user.age != _age)) {
                        await DBProvider.db.changeAge(_age, user.email, user.password);
                        User newuser = await DBProvider.db.loginUser(user.email, user.password);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProvider(
                                  user: newuser,
                                  child: MyBottomNavigationBar(
                                    currentIndex: 2,
                                  ))),
                        );
                      }
                      return null;
                      // Process data
                    }
                  },
                  child: Text(
                    'submit',
                    style: TextStyle(color: Colors.lightGreen[700], fontSize: 25.0),
                  ),
                ))
          ],
        ),
      );
    }

    if (value == 'email') {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter your new e-Mail',
              ),
              style: TextStyle(fontSize: 20.0),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your e-Mail';
                }
                if (value == user.email) {
                  return 'Nothing changed';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _mail = value;
                });
              },
            ),
            SizedBox(height: 24.0),
            Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      if (true && (user.email != _mail)) {
                        await DBProvider.db.changeMail(_mail, user.email, user.password);
                        User newuser = await DBProvider.db.loginUser(_mail, user.password);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProvider(
                                  user: newuser,
                                  child: MyBottomNavigationBar(
                                    currentIndex: 2,
                                  ))),
                        );
                      }
                      return null;
                    }
                  },
                  child: Text(
                    'submit',
                    style: TextStyle(color: Colors.lightGreen[700], fontSize: 25.0),
                  ),
                ))
          ],
        ),
      );
    }

    if (value == 'password') {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter your old password',
              ),
              style: TextStyle(fontSize: 20.0),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _oldpassword = value;
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter your new password',
              ),
              style: TextStyle(fontSize: 20.0),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value == _oldpassword) {
                  return 'Nothing changed';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Confirm it',
              ),
              style: TextStyle(fontSize: 20.0),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value == _oldpassword) {
                  return 'Nothing changed';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            SizedBox(height: 24.0),
            Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      if (true && (_oldpassword != _password) && (user.password != _password)) {
                        await DBProvider.db.changePassword(_password, user.email, user.password);
                        User newuser = await DBProvider.db.loginUser(user.email, _password);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProvider(
                                  user: newuser,
                                  child: MyBottomNavigationBar(
                                    currentIndex: 2,
                                  ))),
                        );
                      }
                      return null;
                      // Process data
                    }
                  },
                  child: Text(
                    'submit',
                    style: TextStyle(color: Colors.lightGreen[700], fontSize: 25.0),
                  ),
                ))
          ],
        ),
      );
    }
  }
}
