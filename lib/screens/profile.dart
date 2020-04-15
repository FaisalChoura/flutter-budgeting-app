import 'package:budget_app/services/auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  AuthService auth = AuthService();
  ProfileScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Logout'),
          onPressed: () {
            auth.signOut();
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ),
    );
  }
}
