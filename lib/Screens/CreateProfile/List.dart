import 'package:flutter/material.dart';

class List extends StatefulWidget {
  List({Key key}) : super(key: key);

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Name:',
              style: TextStyle(
                  color: Colors.lightGreen[700],
                  fontFamily: 'Montserrat',
                  fontSize: 25.0)),
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
          ),
          SizedBox(height: 10.0),
          Text('Age:',
              style: TextStyle(
                  color: Colors.lightGreen[700],
                  fontFamily: 'Montserrat',
                  fontSize: 25.0)),
          TextFormField(
            decoration: const InputDecoration(
                icon: Icon(Icons.cake), hintText: 'Enter your age'),
            style: TextStyle(fontSize: 20.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your age';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          Text('e-Mail:',
              style: TextStyle(
                  color: Colors.lightGreen[700],
                  fontFamily: 'Montserrat',
                  fontSize: 25.0)),
          TextFormField(
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
          ),
          SizedBox(
            height: 10.0,
          ),
          Text('Confirm Password:',
              style: TextStyle(
                  color: Colors.lightGreen[700],
                  fontFamily: 'Montserrat',
                  fontSize: 25.0)),
          TextFormField(
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
