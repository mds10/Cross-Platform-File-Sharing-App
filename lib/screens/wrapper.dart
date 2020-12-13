import 'dart:async';

import 'package:ShareApp/screens/Authentication/authentication.dart';
import 'package:ShareApp/screens/CloudStorage/cloudStorage.dart';
import 'package:ShareApp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  bool _isUserEmailVerified = false;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
        await FirebaseAuth.instance.currentUser()..reload();
        var user = await FirebaseAuth.instance.currentUser();
        if (user.isEmailVerified) {
          setState((){
            _isUserEmailVerified = user.isEmailVerified;
          });
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    print(user);
    if (user == null || !_isUserEmailVerified ) {
      return Authentication();
    }
    else if(user.isEmailVerified) {
      print('The user which is entering the CloudStorage ${user.toString()}');
      return CloudStorage(user: user);
    }
  }
}
