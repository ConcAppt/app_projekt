import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LogList extends StatefulWidget {
  LogList({Key key}) : super(key: key);

  @override
  _LogListState createState() => _LogListState();
}

class _LogListState extends State<LogList> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('e-Mail:',
              style: TextStyle(
                  color: Colors.lightGreen[700],
                  fontFamily: 'Montserrat',
                  fontSize: 25.0)),
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
          ),
          SizedBox(
            height: 10.0,
          ),
          Text('Password:',
              style: TextStyle(
                  color: Colors.lightGreen[700],
                  fontFamily: 'Montserrat',
                  fontSize: 25.0)),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'Enter your password',
            ),
            style: TextStyle(fontSize: 20.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10.0,
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
                    // Process data.
                  }
                },
                child: Text(
                  '  Log In  ',
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
