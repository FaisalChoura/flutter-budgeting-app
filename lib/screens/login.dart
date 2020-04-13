import 'package:budget_app/services/auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('Login with Google'),
            onPressed: () async {
              var user = await auth.googleSignIn();
              if (user != null) {
                Navigator.pushReplacementNamed(context, '/home');
              }
            },
          ),
        ),
      ),
    );
  }
}
