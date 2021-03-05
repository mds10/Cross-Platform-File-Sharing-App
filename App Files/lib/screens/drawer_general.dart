import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  final String title;
  NewPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("New Pages"),
      ),
      body: new Center(
        child: new Text("New Pages To implement"),
      ),
    );
  }
}
