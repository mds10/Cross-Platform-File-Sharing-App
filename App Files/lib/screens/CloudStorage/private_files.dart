import 'package:ShareApp/models/Cloudfile.dart';
import 'package:ShareApp/models/user_model.dart';
import 'package:ShareApp/services/download_file.dart';
import 'package:ShareApp/services/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ShareApp/constants/color_constant.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ShareApp/screens/CloudStorage/previewPrivate.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';

class PrivateFiles extends StatefulWidget {
  final FirebaseUser user;
  PrivateFiles({this.user});

  @override
  _PrivateFilesState createState() => _PrivateFilesState();
}

class _PrivateFilesState extends State<PrivateFiles> {
  List<Cloudfile> pf;
  String _localPath;
  var url;
  bool theFirstOne = true;
  void listFromPF() async {
    // List<Cloudfile> toReturn = [];
    await Storage()
        .listPrivateFiles(widget.user.uid)
        .then((List<Cloudfile> value) {
      pf = value;
      setState(() {});
    });
  }

  String getTheDownloadURI() {
    String File_name;
    // dynamic url;
    final _formKey = GlobalKey<FormState>();
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Text("Key Of File"),
              Spacer(
                flex: 2,
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'File Name'),
                      validator: (val) =>
                          val.isEmpty ? 'Enter File Name' : null,
                      onChanged: (val) {
                        // get File name
                        setState(() => File_name = val);
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      child: Text('Download'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return File_name;
  }

  String getFileFunction() {
    String File_name;
    // dynamic url;
    final _formKey = GlobalKey<FormState>();
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Text("Download File"),
              Spacer(
                flex: 2,
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'File Name'),
                      validator: (val) =>
                          val.isEmpty ? 'Enter File Name' : null,
                      onChanged: (val) {
                        // get File name
                        setState(() => File_name = val);
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      child: Text('Download'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return File_name;
  }

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    // print('This is the user id that we calling from ${widget.user.uid}');
    Future<List<Cloudfile>> privateRecords =
        Storage().listPrivateFiles(widget.user.uid);

    return Scaffold(
      body: FutureBuilder(
        future: privateRecords,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                Cloudfile project = snapshot.data[index];
                return ListTile(
                  title: Text(project.File_name),
                  leading: Icon(Icons.image),
                  trailing: Wrap(
                    spacing: 5,
                    children: [
                      IconButton(
                        icon: Icon(Icons.vpn_key_rounded),
                        onPressed: () {
                          String file_key = project.Key;
                          print(file_key);
                          Clipboard.setData(new ClipboardData(text: file_key));
                          Fluttertoast.showToast(
                              msg: "The key is copied to the clipboard",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.download_rounded),
                        onPressed: () async {
                          String urlInString = await Storage()
                              .downloadPrivateFileWithUrl(
                                  project.LUri, widget.user.uid);

                          Fluttertoast.showToast(
                              msg: "The File URL is downloaded",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          // Code to downlaod files to save one external storage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage(
                                    platform: platform,
                                    title: project.File_name,
                                    urlToDownlaod: urlInString)),
                          );
                          Clipboard.setData(
                              new ClipboardData(text: urlInString));
                          Fluttertoast.showToast(
                              msg: "URL is copied to the clipboard",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => pageToViewImage(
                                cloudfile: project, user: widget.user)));
                  },
                );
              },
            );
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
      ),
    );

//     return Scaffold(
//       body: Align(
//         alignment: Alignment.topCenter,
//         child: Column(children: <Widget>[
//           Row(children: <Widget>[
//             Expanded(
//               flex: 2,
//               child: RaisedButton(
//                 child: Text('DisplayData'),
//                 onPressed: () async {
//                   if (pf != null) {
//                     for (int i = 0; i < pf.length; i++) {
//                       print(pf[i].File_name);
//                     }
//                   }
//                 },
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: RaisedButton(
//                 child: Text('DownloadURl'),
//                 onPressed: () async {
//                   String s = getTheDownloadURI();
//                   url =
//                       Storage().downloadPrivateFileWithUrl(s, widget.user.uid);
//                   if (url == null) {
//                     Fluttertoast.showToast(
//                       msg: "Please provide a valid String",
//                       backgroundColor: Colors.white,
//                       textColor: Colors.black,
//                       fontSize: 16,
//                     );
//                   } else {
//                     // to find the external directory to the files it is platform specific
//                     final directory = await getExternalStorageDirectories();
//                     String location = directory.toString() + 'Download';
//                     // final taskId = await FlutterDownloader.enqueue(
//                     //   url: url,
//                     //   savedDir: location,
//                     //   showNotification:
//                     //       true, // show download progress in status bar (for Android)
//                     //   openFileFromNotification:
//                     //       true, // click on notification to open downloaded file (for Android)
//                     // );
//                     print(url.toString());
//                   }
//                 },
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: RaisedButton(
//                 child: Text('FileFromKey'),
//                 onPressed: () async {
//                   String toSend = getFileFunction();
//                   url = await Storage().fetchFileFromKey(toSend);
//                   if (url == null) {
//                     Fluttertoast.showToast(
//                       msg: "Please provide a valid String",
//                       backgroundColor: Colors.white,
//                       textColor: Colors.black,
//                       fontSize: 16,
//                     );
//                   } else {
//                     print("url: ");
//                     print(url);
//                     // final taskId = await FlutterDownloader.enqueue(
//                     //   url: url,
//                     //   // this has to be updated
//                     //   savedDir:
//                     //       'the path of directory where you want to save downloaded files',
//                     //   showNotification:
//                     //       true, // show download progress in status bar (for Android)
//                     //   openFileFromNotification:
//                     //       true, // click on notification to open downloaded file (for Android)
//                     // );
//                   }
//                 },
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: RaisedButton(
//                 child: Icon(Icons.refresh),
//                 onPressed: () async {
//                   // Storage().uploadFileToPrivate()
//                   await Storage()
//                       .listPrivateFiles(widget.user.uid)
//                       .then((List<Cloudfile> value) {
//                     pf = value;
//                     setState(() {});
//                   });
//                 },
//               ),
//             ),
//           ]),
//           FutureBuilder(
//             future: privateRecords,
//             builder: (context, snapshot) {
//               if (snapshot.hasData &&
//                   snapshot.connectionState == ConnectionState.done) {
//                 return Row(children: <Widget>[
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: ListView.separated(
//                         shrinkWrap: true,
//                         itemCount: snapshot.data.length,
//                         separatorBuilder: (context, index) => Divider(),
//                         itemBuilder: (context, index) {
//                           Cloudfile project = snapshot.data[index];
//                           print(project.toString());
//                           return ListTile(
//                             title: Text(project.File_name),
//                             leading: Icon(Icons.image),
//                             // subtitle: Text(project.LUri),
//                             onTap: () {},
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ]);
//                 // return Row(children: <Widget>[
//                 //   Expanded(
//                 //     child: SingleChildScrollView(
//                 //       child: ListView.separated(
//                 //         // shrinkWrap: true,
//                 //         itemCount: snapshot.data.length,
//                 //         separatorBuilder: (context, index) => Divider(),
//                 //         itemBuilder: (context, index) {
//                 //           Cloudfile project = snapshot.data[index];
//                 //           print(
//                 //               'This is the object that we getting in private ::');
//                 //           print(project.toString());
//                 //           return ListTile(
//                 //             title: Text(project.File_name),
//                 //             leading: Icon(Icons.image),
//                 //             subtitle: Text(project.LUri),
//                 //             onTap: () {
//                 //               print('file name if ${project.File_name}');
//                 //             },
//                 //           );
//                 //         },
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ]);
//               } else {
//                 return Center(
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(height: 100),
//                       CircularProgressIndicator(),
//                     ],
//                   ),
//                 );
//               }
//             },
//           ),
//         ]),
//       ),
//     );
  }
}
