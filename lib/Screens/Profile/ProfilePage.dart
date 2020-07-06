import 'package:appprojekt/Widgets/MyBottomNavigationBar.dart';
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
        centerTitle: true,
        title: Text('Your Profile',
            style: TextStyle(color: Colors.grey[200], fontFamily: 'Montserrat', fontSize: 25.0)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Name',
                    style: TextStyle(
                        color: Colors.lightGreen[700], fontFamily: 'Montserrat', fontSize: 25.0)),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 140,
                      child: Text(user.name,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right, size: 20),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Age',
                    style: TextStyle(
                        color: Colors.lightGreen[700], fontFamily: 'Montserrat', fontSize: 25.0)),
                Row(
                  children: <Widget>[
                    Text(user.age.toString(),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 20.0)),
                    IconButton(
                      icon: Icon(Icons.chevron_right, size: 20),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('E-Mail',
                    style: TextStyle(
                        color: Colors.lightGreen[700], fontFamily: 'Montserrat', fontSize: 25.0)),
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
                      icon: Icon(Icons.chevron_right, size: 20),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Password',
                    style: TextStyle(
                        color: Colors.lightGreen[700], fontFamily: 'Montserrat', fontSize: 25.0)),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 140,
                      child: Text(String.fromCharCode(0x2022) * user.password.length,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right, size: 20),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
