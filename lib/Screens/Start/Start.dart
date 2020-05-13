import 'package:flutter/material.dart';
import 'package:appprojekt/Screens/LogIn/LogIn.dart';
import 'package:appprojekt/Screens/CreateProfile/CaP.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Hello!',
                style: TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'Montserrat',
                  color: Colors.black87,
                ),
              ),
            ),
            Center(
              child: Text(
                'Good to see you.',
                style: TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'Montserrat',
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Container(
                child: RaisedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CaP()),
                    );
                  },
                  color: Colors.lightGreen[700],
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'Create Profile',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'Montserrat',
                      letterSpacing: 3.0,
                      color: Colors.grey[100],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
            ),
            SizedBox(height: 20.0),
            Container(
                child: RaisedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  },
                  color: Colors.lightGreen[700],
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),

                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'Montserrat',
                      letterSpacing: 3.0,
                      color: Colors.grey[100],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}


// TODO Implement this library.