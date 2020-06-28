import 'package:appprojekt/Screens/Profile/ProfilePage.dart';
import 'package:appprojekt/utils/Database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appprojekt/models/user.dart';

class List extends StatefulWidget {
  List({Key key}) : super(key: key);

  @override
  _ListState createState() => _ListState();
}

enum Department { back }

class _ListState extends State<List> {
  String _name;
  int _age;
  String _email;
  String _password;
  String _confirmpassword;
  final _formKey = GlobalKey<FormState>();

  Future<void> openDialog() async {
    switch (await showDialog<Department>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text("Passwords don't match"),
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
            ],
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(10)),
          );
        })) {
      case Department.back:
        print("klappt");
        //....
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Name:',
              style: TextStyle(
                  color: Colors.lightGreen[700], fontFamily: 'Montserrat', fontSize: 25.0)),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter your name',
            ),
            style: TextStyle(fontSize: 20.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _name = value;
              });
            },
          ),
          SizedBox(height: 10.0),
          Text('Age:',
              style: TextStyle(
                  color: Colors.lightGreen[700], fontFamily: 'Montserrat', fontSize: 25.0)),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(icon: Icon(Icons.cake), hintText: 'Enter your age'),
            style: TextStyle(fontSize: 20.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your age';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _age = int.tryParse(value);
              });
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          Text('e-Mail:',
              style: TextStyle(
                  color: Colors.lightGreen[700], fontFamily: 'Montserrat', fontSize: 25.0)),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              hintText: 'Enter your e-Mail',
            ),
            style: TextStyle(fontSize: 20.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your e-Mail';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          Text('Password:',
              style: TextStyle(
                  color: Colors.lightGreen[700], fontFamily: 'Montserrat', fontSize: 25.0)),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'Enter your Password',
            ),
            style: TextStyle(fontSize: 20.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your Password';
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
          Text('Confirm Password:',
              style: TextStyle(
                  color: Colors.lightGreen[700], fontFamily: 'Montserrat', fontSize: 25.0)),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'Enter your Password',
            ),
            style: TextStyle(fontSize: 20.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your Password';
              }
              if (value != _password) {
                print('Passwords do not match');
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _confirmpassword = value;
              });
            },
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                color: Colors.lightGreen[700],
                highlightElevation: 2,
                elevation: 8,
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    if (true && (_password == _confirmpassword)) {
                      var newDBUser =
                          User(name: _name, age: _age, email: _email, password: _password);
                      DBProvider.db.newUser(newDBUser);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    }
                    if (true && (_password != _confirmpassword)) {
                      openDialog();
                    }
                    // Process data
                  }
//                  _create();
                },
                child: Text(
                  '  Create Profile  ',
                  style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'Montserrat',
                      color: Colors.grey[200],
                      letterSpacing: 5,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} // TODO Implement this library.
/*
_create() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'my_int_key';
  final value = 42;
  prefs.setString(key);
  print('saved $value');
}
}*/
