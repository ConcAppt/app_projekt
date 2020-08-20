import 'package:appprojekt/Screens/Start/Start.dart';
import 'package:appprojekt/Widgets/MyBottomNavigationBar.dart';
import 'package:appprojekt/data/Database.dart';
import 'package:appprojekt/models/user.dart';
import 'package:flutter/material.dart';

import '../../Widgets/UserProvider_InWi.dart';
import '../../Widgets/UserProvider_InWi.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = UserProvider.of(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0),
        child: AppBar(
          backgroundColor: Colors.lightGreen[400],
          automaticallyImplyLeading: false,
        ),
      ),
      body: SafeArea(
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
              child: Text('This is your Profile.',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Name:',
                    style: TextStyle(
                        color: Colors.lightGreen[700], fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 25.0)),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 195,
                      child: Text(UserProvider.of(context).user.name,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0)),
                    ),
                    IconButton(
                      icon: Icon(Icons.create, size: 20),
                      onPressed: () async{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog("name", user),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Age:',
                    style: TextStyle(
                        color: Colors.lightGreen[700], fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 25.0)),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 220,
                      child: Text(UserProvider.of(context).user.age.toString(),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 25.0)),
                    ),
                    IconButton(
                      icon: Icon(Icons.create, size: 20),
                      onPressed: () async{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog("age", user),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 140,
                  child: Text('E-Mail:',
                      style: TextStyle(
                          color: Colors.lightGreen[700], fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 25.0)),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 140,
                      child: Text(user.email,
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                    ),
                    IconButton(
                      icon: Icon(Icons.create, size: 20),
                      onPressed: () async{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog("email", user),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 140,
                  child: Text('Password:',
                      style: TextStyle(
                          color: Colors.lightGreen[700], fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 25.0)),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 140,
                      child: Text(String.fromCharCode(0x2022) * UserProvider.of(context).user.password.length,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0)),
                    ),
                    IconButton(
                      icon: Icon(Icons.create, size: 20),
                      onPressed: () async{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog("password", user),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Container(
              height: 3.0,
              color: Colors.lightGreen[400],
            ),
            SizedBox(height: 50.0),
            Center(
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                color: Colors.lightGreen[700],
                highlightElevation: 2,
                elevation: 8,
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => Start()));
                },
                child: Text(
                  '  Log Out  ',
                  style: TextStyle(
                  fontSize: 28.0,
                  fontFamily: 'Montserrat',
                  color: Colors.grey[200],
                  letterSpacing: 5,
                  fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {
  CustomDialog(this.value, this.user);
  final value;
  final user;
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final _formKey = GlobalKey<FormState>();

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
    return Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.all(30.0),
          decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                )
              ]),
          child:
          Column(mainAxisSize: MainAxisSize.min, // To make the card compact
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
              ])),
    ],
    );
  }

  Widget getText(String value, User user){
    String _name;
    String _age;
    String _mail;
    String _password;

    String _oldname;
    String _oldage;
    String _oldemail;
    String _oldpassword;

    if(value == 'name'){
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
                if (value == user.name){
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
                  onPressed: () async{
                    if (_formKey.currentState.validate()) {
                      if (true && (_oldname != _name)) {
                          await DBProvider.db.changeName(user.email, user.password, _name);
                          Navigator.pop(context);
                      }
                      // Process data
                    }
                  },
                  child: Text('submit',
                    style: TextStyle(
                        color: Colors.lightGreen[700],
                        fontSize: 25.0),),
                ))
          ],
        ),
      );}



    if(value == 'age'){
      return Column(
        children: [
          SizedBox(height: 10.0,),
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
              if (value == user.age.toString()){
                return 'Nothing changed';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _age = value;
              });
            },
          ),
          SizedBox(height: 24.0),
          Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                onPressed: () async{
                  if (_formKey.currentState.validate()) {
                    if (true && (_oldname != _name)) {
                      await DBProvider.db.changeName(user.email, user.password, _name);
                      Navigator.pop(context);
                    }
                    // Process data
                  }
                },
                child: Text('submit',
                  style: TextStyle(
                      color: Colors.lightGreen[700],
                      fontSize: 25.0),),
              ))
        ],
      );}


    if(value == 'email'){
      return Column(
        children: [
          SizedBox(height: 10.0,),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter your new e-Mail',
            ),
            style: TextStyle(fontSize: 20.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your e-Mail';
              }
              if (value == user.email){
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
                onPressed: () async{
                  if (_formKey.currentState.validate()) {
                    if (true && (_oldname != _name)) {
                      await DBProvider.db.changeName(user.email, user.password, _name);
                      Navigator.pop(context);
                    }
                    // Process data
                  }
                },
                child: Text('submit',
                  style: TextStyle(
                      color: Colors.lightGreen[700],
                      fontSize: 25.0),),
              ))
        ],
      );}


    if(value == 'password'){
      return Column(
        children: [
          TextFormField(
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
          SizedBox(height: 10.0,),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter your new password',
            ),
            style: TextStyle(fontSize: 20.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your password';
              }
              if (value == _oldpassword){
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
                onPressed: () async{
                  if (_formKey.currentState.validate()) {
                    if (true && (_oldname != _name)) {
                      await DBProvider.db.changeName(user.email, user.password, _name);
                      Navigator.pop(context);
                    }
                    // Process data
                  }
                },
                child: Text('submit',
                  style: TextStyle(
                      color: Colors.lightGreen[700],
                      fontSize: 25.0),),
              ))
        ],
      );}
  }
}


