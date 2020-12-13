import 'package:ShareApp/screens/History/history.dart';
import 'package:ShareApp/screens/Local_Sharing/local_sharing.dart';
import 'package:ShareApp/screens/wrapper.dart';
import 'package:ShareApp/screens/Settings/settings.dart';
import 'package:flutter/material.dart';

class ShowScreen extends StatefulWidget {
  final int index;
  ShowScreen({this.index});

  @override
  _ShowScreenState createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.index == 0) {
      return Local_Sharing();
    } else if (widget.index == 1) {
      return Wrapper();
    } else if (widget.index == 2) {
      return History();
    } else {
      return Settings();
    }
  }
}
