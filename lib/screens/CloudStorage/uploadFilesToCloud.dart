import 'package:ShareApp/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:ShareApp/services/storage.dart';
import 'package:ShareApp/models/buttontapped.dart';

class uploadFilesToCloud extends StatefulWidget {
  var path;
  String uid;
  uploadFilesToCloud({this.path, this.uid});

  @override
  _uploadFilesToCloudState createState() => _uploadFilesToCloudState();
}

class _uploadFilesToCloudState extends State<uploadFilesToCloud> {
  Storage st = new Storage();
  String file_name = "";
  List<String> tag = [];
  String tagString = "";
  List<String> _choices = ['PublicUpload', 'PrivateUpload'];
  int _defaultSelectedIndex = 0;
  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _controllerTag = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    String content = "", names = "";
    for (int i = 0; i < widget.path.length; i++) {
      content += widget.path.values.toList()[i];
      names += widget.path.keys.toList()[i];
    }
    _controller.text = names;
    file_name = _controller.text;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Upload Files to Cloud'),
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: MediaQuery.of(context).size.width / 3 - 30),
                ChoiceChip(
                  label: Text(_choices[0]),
                  selected: _defaultSelectedIndex == 0,
                  onSelected: (bool selected) {
                    setState(() {
                      _defaultSelectedIndex = selected ? 0 : 0;
                      print(_defaultSelectedIndex);
                    });
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text(_choices[1]),
                  selected: _defaultSelectedIndex == 1,
                  onSelected: (bool selected) {
                    setState(() {
                      _defaultSelectedIndex = selected ? 1 : 0;
                      print(_defaultSelectedIndex);
                    });
                  },
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(6, 20, 6, 10),
              child: Container(
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => _controller.clear(),
                      icon: Icon(Icons.clear_rounded),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    prefixIcon: Icon(Icons.file_copy),
                    hintText: 'Name of the file',
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (val) {
                    file_name = val;
                  },
                ),
              ),
            ),
            if (_defaultSelectedIndex == 0)
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 20, 6, 10),
                child: Container(
                  child: TextFormField(
                    controller: _controllerTag,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () => _controllerTag.clear(),
                        icon: Icon(Icons.clear_rounded),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      hintText: 'Tag for the file',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onChanged: (val) {
                      tagString = val;
                    },
                  ),
                ),
              ),
            if (_defaultSelectedIndex == 1) SizedBox(height: 89),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (_defaultSelectedIndex == 0) {
                          tag = tagString.split(" ");
                          await st.uploadFileToPublic(
                              file_name, widget.path.values.toList()[0], tag);
                        } else {
                          await st.uploadFileToPrivate(file_name,
                              widget.path.values.toList()[0], widget.uid);
                        }
                        Navigator.of(context).pop();
                      },
                      child: ButtonTapped(icon: Icons.upload_sharp),
                    ),
                  ),
                ),
              ],
            ),

            // Row(
            //   children: <Widget>[
            //     SizedBox(height: 10),
            //     Icon(Icons.file_present),
            //     Text(names, overflow: TextOverflow.clip),
            //   ],
            // ),
            // RaisedButton(
            //   child: Text('Upload Publicly'),
            //   onPressed: () async {
            //     await publicUploadDialog();
            //     Navigator.of(context).pop();
            //     // st.uploadFileToPublic('new.jpg', widget.path.values.toList()[0], tags);
            //   },
            // ),
            // RaisedButton(
            //   child: Text('Uplaod Privately'),
            //   onPressed: () async {
            //     await privateUploadDialog();
            //     Navigator.of(context).pop();
            //   },
            // )
          ],
        ),
      ),
    );
  }

  Future<void> publicUploadDialog() async {
    String File_name;
    List<String> tags;
    final _formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Text("Public Uploads"),
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
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Tags'),
                      validator: (val) => val.isEmpty ? 'Enter Tags' : null,
                      onChanged: (val) {
                        // get Tags
                        setState(() => tags = val.split(" "));
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      child: Text('Upload'),
                      onPressed: () async {
                        await st.uploadFileToPublic(
                            File_name, widget.path.values.toList()[0], tags);
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
  }

  Future<void> privateUploadDialog() async {
    String File_name;
    final _formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Text("Private Uploads"),
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
                      child: Text('Upload'),
                      onPressed: () async {
                        await st.uploadFileToPrivate(File_name,
                            widget.path.values.toList()[0], widget.uid);
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
  }
}
