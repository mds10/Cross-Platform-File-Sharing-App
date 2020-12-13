import 'package:ShareApp/services/download_file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ShareApp/models/Cloudfile.dart';
import 'package:ShareApp/services/storage.dart';

class pageToViewImagep extends StatefulWidget {
  final Cloudfile cloudfile;
  final TargetPlatform platform;
  const pageToViewImagep({Key key, this.cloudfile, this.platform})
      : super(key: key);

  @override
  _pageToViewImagepState createState() => _pageToViewImagepState();
}

class _pageToViewImagepState extends State<pageToViewImagep> {
  @override
  Widget build(BuildContext context) {
    var url = Storage().downloadPublicFileWithUrl(widget.cloudfile.LUri);
    return FutureBuilder<dynamic>(
      future: url,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text("Download"),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.download_rounded),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                platform: widget.platform,
                                title: "File to Downlaod",
                                urlToDownlaod: snapshot.data),
                          ));
                    }),
              ],
            ),
            body: Center(
              child: Container(
                child: Image.network(snapshot.data),
              ),
            ),
          );
        } else {
          return Center(
              child: Container(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }
}
