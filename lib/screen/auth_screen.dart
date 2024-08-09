import 'package:flutter/material.dart';
import 'package:shoes_shop/screen/login_screen.dart';
import 'package:shoes_shop/screen/sign_up_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLogin
          ? LoginScreen(toggleForm: toggleForm)
          : SignUp(toggleForm: toggleForm),
    );
  }
}
