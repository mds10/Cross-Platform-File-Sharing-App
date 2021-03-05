import 'package:ShareApp/screens/Authentication/register.dart';
import 'package:ShareApp/screens/Authentication/sing_in.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;
  void toggelView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return (showSignIn
        ? SignIn(toggelView: toggelView)
        : Register(toggelView: toggelView));
  }
}
