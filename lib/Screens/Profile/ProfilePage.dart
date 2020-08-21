import 'package:appprojekt/Screens/Start/Start.dart';
import 'package:appprojekt/Widgets/MyBottomNavigationBar.dart';
import 'package:appprojekt/data/Database.dart';
import 'package:appprojekt/models/user.dart';
import 'package:flutter/material.dart';

import '../../Widgets/UserProvider_InWi.dart';
import '../../Widgets/UserProvider_InWi.dart';
import 'PopUp_Change.dart';

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
      ),
    );
  }
}



