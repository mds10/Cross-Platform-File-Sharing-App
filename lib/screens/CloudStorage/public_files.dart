import 'dart:io';

import 'package:ShareApp/models/Cloudfile.dart';
import 'package:ShareApp/screens/CloudStorage/previewpagePublic.dart';
import 'package:ShareApp/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ShareApp/services/download_file.dart';
// import 'package:ShareApp/constants/data_search.dart';

class PublicFiles extends StatefulWidget {
  @override
  _PublicFilesState createState() => _PublicFilesState();
}

class _PublicFilesState extends State<PublicFiles> {
  //List<Cloudfile> pf = new List();
  Future<List<Cloudfile>> record;

  @override
  void initState() {
    super.initState();
    // this should not be done in build method.
    record = Storage().listPublicFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildListView(),
    );
  }

  Widget buildListView() {
    final platform = Theme.of(context).platform;
    return FutureBuilder<List<Cloudfile>>(
      future: record,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            // separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              Cloudfile project = snapshot.data[index];
              print(project.toString());
              return ListTile(
                title: Text(project.File_name),
                leading: Icon(Icons.image),
                subtitle: Text(project.LUri),
                trailing: GestureDetector(
                  onTap: () async {
                    // url
                    String urlInString =
                        await Storage().downloadPublicFileWithUrl(project.LUri);
                    setState(() {});
                    // Code to downlaod files to save one external storage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(
                              platform: platform,
                              title: project.File_name,
                              urlToDownlaod: urlInString)),
                    );
                    Fluttertoast.showToast(
                        msg: "The File URL is downloaded",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);

                    Clipboard.setData(new ClipboardData(text: urlInString));
                    Fluttertoast.showToast(
                        msg: "The URL is copied to clipboard",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: Icon(Icons.download_rounded),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              pageToViewImagep(cloudfile: project)));
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Some error is occured..hit refersh again');
        } else {
          return Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 100),
                CircularProgressIndicator(),
              ],
            ),
          );
        }
      },
    );
  }
}
