import 'package:appprojekt/Screens/Profile/ProfilePage.dart';
import 'package:flutter/material.dart';
//import 'package:email_validator/email_validator.dart';
import 'package:appprojekt/models/user.dart';
import 'package:appprojekt/data/Database.dart';

class LogList extends StatefulWidget {
  LogList({Key key}) : super(key: key);

  @override
  _LogListState createState() => _LogListState();
}

enum Department{ back }

class _LogListState extends State<LogList> {
  Map<String, dynamic> newUser = {};
  final _formKey = GlobalKey<FormState>();
  DBProvider database;
  String _email;
  String _password;

  Future<void> openDialog() async {
    switch (await showDialog<Department>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text("Wrong e-Mail or password"),
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
      //....
        break;
    }
  }
  /*Future<User> _loginUser (String email, String password) async{
    User newUser = User.fromJson({
        email: "support@appprojekt.de",
        password: "appprojekt12"
    });
    await DBProvider.db.newUser(newUser).then((val) async{
      if (val == 1) {
        User user = await DBProvider.db.loginUser(email, password);

        return user;
      }
    });
  }*/

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
              onChanged: (value){
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
              onChanged: (value){
                setState(() {
                  _password = value;
                });
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
                  onPressed: () async {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState.validate()) {
                      // Process data.
                      if (true) {
                        User user = await DBProvider.db.loginUser(
                            _email, _password);

                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
                          );
                        } else {
                          openDialog();
                        }
                      }
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



/*class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LogInState()
  }
}

class LogInState extends State<LogIn> implements LogInContract, AuthStateListener {
  BuildContext _ctx;

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _password;
  String _email;

  LogInPresenter _presenter;

  LogInState() {
    _presenter = new LogInPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _presenter.doLogin((_email), _password)
    }
  }

  @override
  onAuthStateChanged(AuthState state) {
    if(state == AuthState.LOGGED_IN)
      Navigator.of(_ctx).pushReplacementNamed("/profile")
  }
}


class LogList extends StatefulWidget {
  LogList({Key key}) : super(key: key);

  @override
  _LogListState createState() => _LogListState();
}

class _LogListState extends State<LogList> implements LogInContract, AuthStateListener{
  BuildContext _ctx;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _password;
  String _email;

  LogInPresenter _presenter;

  _LogListState() {
    _presenter = new LogInPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  onAuthStateChanged(AuthState state) {
    if(state == AuthState.LOGGED_IN)
      Navigator.of(_ctx).pushReplacementNamed("/profile");
  }

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
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
            onChanged: (value){
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
            onChanged: (value){
              setState(() {
                _password = value;
              });
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
                      setState(() => _isLoading = true);
                      _formKey.currentState.save();
                      _presenter.doLogin((_email), _password);
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

  @override
  void onLoginSuccess(User user)async {
    _showSnackBar(user.toString());
    setState(() => _isLoading = false);
    //var db = new DBProvider();
    await DBProvider.db.loginUser(email, password);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
  }
} // TODO Implement this library.
*/

