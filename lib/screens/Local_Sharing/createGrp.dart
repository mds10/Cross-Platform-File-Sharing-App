import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ShareApp/models/add_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ShareApp/screens/Local_Sharing/paths_data.dart';
import 'package:ShareApp/screens/Local_Sharing/apk_list.dart';
import 'package:intl/intl.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ShareApp/models/message_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

String cId = "0";
final mymessage = TextEditingController();
Map<String, String> _paths;
bool _isadvertising = false;
ValueNotifier<bool> _status = ValueNotifier<bool>(false);
Map<String, ConnectionInfo> usermap = {};
List<String> userids = [];
List<Message> messages = [
  Message(
    sender: 'Admin',
    text: 'You Can Start You Conversation Here..',
  ),
];

//   REcieve Main APP bar
class createGrp extends StatefulWidget {
  String userName;
  createGrp(String uname) {
    this.userName = uname;
  }
  @override
  _createGrpState createState() => _createGrpState(userName);
}

class _createGrpState extends State<createGrp> {
  String userName;

  _createGrpState(String uname) {
    //    Constructor
    this.userName = uname;
  }
  // List to save data
  List<SaveData> check = [];
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSP();
  }

  // LOADING THE SHARED PREFERENCES
  void loadSP() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      saveData();
    });
  }

  // AND SAVING THE DATA TO SHAREDPREFERENCES
  void saveData() {
    List<String> spList = check.map((e) => jsonEncode(e.toMap())).toList();
    sharedPreferences.setStringList('check', spList);
  }

  // TO SAVE THE DATA IN check LIST OF SAVEDATA TYPE
  void appendList(String fileName, String whichSide, String otherUserId) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    check.add(
      SaveData(
          fileName: fileName,
          whichSide: whichSide,
          dateTime: formattedDate,
          otherUserId: otherUserId),
    );
    saveData();
  }

  _chatbubble(Message message, bool isMe) {
    if (isMe) {
      return Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.topLeft,
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.65),
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration:
                      BoxDecoration(color: Colors.blue[100], boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ]),
                  child: Text(message.text),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(message.sender),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.topRight,
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.65),
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration:
                      BoxDecoration(color: Colors.blue[100], boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ]),
                  child: Text(message.text),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Text(message.sender),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            centerTitle: true,
            title: Center(
              child: Text(
                "Group Host",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.contacts_outlined),
                  onPressed: () {
                    _showusers();
                  }),
              IconButton(
                //   qr code
                icon: Icon(Icons.qr_code),
                onPressed: () {
                  _showMyDialog();
                },
              ),
              IconButton(
                icon: Icon(Icons.android_outlined),
                onPressed: () {
                  getapkpaths();
                },
              )
            ],
          ),
        ),
        //  JUST WE HAVE TO CHANGE THE BODY
        // body: recvOneBody(userName),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: ValueListenableBuilder(
                  builder: (BuildContext context, bool value, Widget child) {
                    return Row(
                      //    status display
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            height: 20.0,
                            color: value ? Colors.green : Colors.grey,
                            child: Center(
                                child:
                                    Text(value ? "Connected" : "Disconnected")),
                          ),
                        ),
                      ],
                    );
                  },
                  valueListenable: _status,
                ),
              ),
              recvOneBody(userName),
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    bool isMe = true;
                    return _chatbubble(messages[index], isMe);
                  },
                ),
              ),
              // Here Comes the text editor
              Container(
                //      Text Box
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                height: 70.0,
                color: Colors.amber,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.attach_file),
                      iconSize: 25.0,
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        _paths = await FilePicker.getMultiFilePath();
                        Fluttertoast.showToast(
                          msg: "click send to send files",
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16,
                        );
                      },
                    ),
                    Expanded(
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: mymessage,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Enter message ...'),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      iconSize: 25.0,
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }

                        if (_status.value) {
                          for (int i = 0; i < userids.length; i++) {
                            cId = userids[i];
                            if (_paths != null) {
                              for (int i = 0; i < _paths.length; i++) {
                                int payloadId = await Nearby().sendFilePayload(
                                    cId, _paths.values.toList()[i]);
                                Message n = new Message();
                                String s =
                                    "Sending ${_paths.keys.toList()[i]} to $cId";
                                n.text = s;
                                n.sender = cId;
                                messages.add(n);
                                appendList(
                                    _paths.keys.toList()[i], "Send", cId);
                                Nearby().sendBytesPayload(
                                    cId,
                                    Uint8List.fromList(
                                        "$payloadId:${_paths.values.toList()[i].split('/').last}"
                                            .codeUnits));
                              }
                              _paths = null;
                            }
                            Message n = new Message();
                            String s = mymessage.text;
                            n.text = s;
                            n.sender = cId;
                            if (n.text != "") {
                              messages.add(n);
                              Nearby().sendBytesPayload(cId,
                                  Uint8List.fromList(mymessage.text.codeUnits));
                              setState(() {});
                              Fluttertoast.showToast(
                                msg: s,
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 16,
                              );
                            }
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg: "Device is not Connected",
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 16,
                          );
                        }
                        mymessage.clear();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showusers() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Text("Current Users"),
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
          content: Scrollbar(
            child: Container(
              height: 500,
              child: Center(
                child: RepaintBoundary(
                    child: ListView.builder(
                        itemCount: userids.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return new Text(usermap[userids[index]].endpointName);
                        })),
              ),
            ),
          ),
        );
      },
    );
  }

  void getapkpaths() async {
    final dataFromSecondPage = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApkExtractor()),
    ) as Data;
    _paths = dataFromSecondPage.path;
    print(_paths);
    Fluttertoast.showToast(
      msg: "click send to send apk",
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16,
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Text("QR Code"),
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
            child: Center(
              child: RepaintBoundary(
                child: QrImage(
                  data: userName,
                  size: 250,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class recvOneBody extends StatefulWidget {
  String userName;
  recvOneBody(String uname) {
    //    Constructor
    this.userName = uname;
  }

  @override
  _recvOneBodyState createState() => _recvOneBodyState(userName);
}

class _recvOneBodyState extends State<recvOneBody> {
  String userName; //   username
  // final mymessage = TextEditingController(); //   Sending message
  final Strategy strategy = Strategy.P2P_STAR; //   Strategy of connection (P2P)
  // String cId = "0"; //   currently connected device ID
  File tempFile; //   reference to the file currently being transferred
  Map<int, String> map =
      Map(); //   store filename mapped to corresponding payloadId

  // ValueNotifier<bool> _status = ValueNotifier<bool>(false);

  _recvOneBodyState(String uname) {
    //    Constructor
    this.userName = uname;
  }

  @override
  void dispose() {
    //   TextField
    // Clean up the controller when the widget is disposed.
    // mymessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: RaisedButton(
                child: Text('Create Room'),
                color: Colors.amber,
                onPressed: () async {
                  if (_isadvertising == false) {
                    _isadvertising = true;
                    try {
                      Fluttertoast.showToast(
                        msg: "Advertising",
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 16,
                      );
                      print("Advertisement starts");
                      bool a = await Nearby().startAdvertising(
                        userName,
                        strategy,
                        onConnectionInitiated: onConnectionInit,
                        onConnectionResult: (id, status) {
                          if (status == Status.CONNECTED) {
                            Fluttertoast.showToast(
                              msg: id + " is Connected",
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16,
                            );
                            _status.value = true;
                            userids.add(id);
                            for (int i = 0; i < userids.length; i++) {
                              cId = userids[i];
                              if (cId != id) {
                                Nearby().sendBytesPayload(
                                    cId,
                                    Uint8List.fromList(
                                        (usermap[id].endpointName +
                                                " connected")
                                            .codeUnits));
                              }
                              _status.value = true;
                            }
                          }
                          print(status);
                          showSnackbar(status);
                        },
                        onDisconnected: (id) {
                          for (int i = 0; i < userids.length; i++) {
                            if (id == userids[i]) {
                              userids.removeAt(i);
                            }
                          }
                          if (userids.length == 0) {
                            _status.value = false;
                          }
                          Fluttertoast.showToast(
                            msg: id + " is Disconnected",
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 16,
                          );
                          showSnackbar("Disconnected: " + id);
                        },
                      );
                      showSnackbar("ADVERTISING: " + a.toString());
                    } catch (exception) {
                      showSnackbar(exception);
                    }
                  } else {
                    Fluttertoast.showToast(
                      msg: "Already Advertising",
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      fontSize: 16,
                    );
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: RaisedButton(
                child: Text('End room '),
                color: Colors.amber,
                onPressed: () async {
                  await Nearby().stopAllEndpoints();
                  if (_isadvertising && _status.value == false) {
                    Fluttertoast.showToast(
                      msg: "Stopped Advertising",
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      fontSize: 16,
                    );
                  } else if (_status.value) {
                    Fluttertoast.showToast(
                      msg: "Disconnecting",
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      fontSize: 16,
                    );
                  }
                  _isadvertising = false;
                  _status.value = false;
                },
              ),
            ),
          )
        ],
      ),
      // Container(
      //   //      Text Box
      //   padding: EdgeInsets.symmetric(horizontal: 8.0),
      //   height: 70.0,
      //   color: Colors.amber,
      //   child: Row(
      //     children: <Widget>[
      //       IconButton(
      //         icon: Icon(Icons.attach_file),
      //         iconSize: 25.0,
      //         color: Theme.of(context).primaryColor,
      //         onPressed: () {
      //           // file transfer
      //         },
      //       ),
      //       Expanded(
      //         child: TextField(
      //           textCapitalization: TextCapitalization.sentences,
      //           controller: mymessage,
      //           decoration:
      //               InputDecoration.collapsed(hintText: 'Enter message ...'),
      //         ),
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.send),
      //         iconSize: 25.0,
      //         color: Theme.of(context).primaryColor,
      //         onPressed: () async {
      //           // mymessage text have to displayed on the main screen
      //           showSnackbar("Sending ${mymessage.text} to $cId");
      //           Nearby().sendBytesPayload(
      //               cId, Uint8List.fromList(mymessage.text.codeUnits));
      //         },
      //       )
      //     ],
      //   ),
      // ),
    ]);
  }

  void showSnackbar(dynamic a) {
    //    snackbar
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(a.toString()),
    ));
  }

  void onConnectionInit(String id, ConnectionInfo info) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Center(
          child: Column(
            children: <Widget>[
              Text("id: " + id),
              Text("Token: " + info.authenticationToken),
              Text("Name" + info.endpointName),
              Text("Incoming: " + info.isIncomingConnection.toString()),
              RaisedButton(
                child: Text("Accept Connection"),
                onPressed: () {
                  if (userName == null) {
                    Fluttertoast.showToast(
                      msg: "Still null",
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      fontSize: 16,
                    );
                  } else
                    usermap.putIfAbsent(id, () => info);
                  Navigator.pop(context);
                  Nearby().acceptConnection(
                    id,
                    onPayLoadRecieved: (endid, payload) async {
                      if (payload.type == PayloadType.BYTES) {
                        Message n = new Message();
                        String str = String.fromCharCodes(payload.bytes);
                        n.text = str;
                        n.sender = endid;
                        messages.add(n);
                        setState(() {});
                        for (int i = 0; i < userids.length; i++) {
                          cId = userids[i];
                          if (cId != id) {
                            Nearby().sendBytesPayload(
                                cId, Uint8List.fromList((str).codeUnits));
                          }
                        }

                        //showSnackbar(endid + ": " + str);

                        if (str.contains(':')) {
                          // used for file payload as file payload is mapped as
                          // payloadId:filename
                          int payloadId = int.parse(str.split(':')[0]);
                          String fileName = (str.split(':')[1]);

                          if (map.containsKey(payloadId)) {
                            if (await tempFile.exists()) {
                              tempFile.rename(
                                  tempFile.parent.path + "/" + fileName);
                            } else {
                              showSnackbar("File doesnt exist");
                            }
                          } else {
                            //add to map if not already
                            map[payloadId] = fileName;
                          }
                        }
                      } else if (payload.type == PayloadType.FILE) {
                        showSnackbar(endid + ": File transfer started");
                        tempFile = File(payload.filePath);
                      }
                    },
                    onPayloadTransferUpdate:
                        (endid, payloadTransferUpdate) async {
                      if (payloadTransferUpdate.status ==
                          PayloadStatus.IN_PROGRRESS) {
                        print(payloadTransferUpdate.bytesTransferred);
                      } else if (payloadTransferUpdate.status ==
                          PayloadStatus.FAILURE) {
                        print("failed");
                        showSnackbar(endid + ": FAILED to transfer file");
                      } else if (payloadTransferUpdate.status ==
                          PayloadStatus.SUCCESS) {
                        for (int i = 0; i < userids.length; i++) {
                          cId = userids[i];
                          if (cId != id) {
                            int payloadId = await Nearby().sendFilePayload(
                                cId, _paths.values.toList()[i]);
                            Nearby().sendBytesPayload(
                                cId,
                                Uint8List.fromList(
                                    "$payloadId:${tempFile.path.split('/').last}"
                                        .codeUnits));
                          }
                        }
                        showSnackbar(
                            "success, total bytes = ${payloadTransferUpdate.totalBytes}");

                        if (map.containsKey(payloadTransferUpdate.id)) {
                          //rename the file now
                          String name = map[payloadTransferUpdate.id];
                          tempFile.rename(tempFile.parent.path + "/" + name);
                        } else {
                          //bytes not received till yet
                          map[payloadTransferUpdate.id] = "";
                        }
                      }
                    },
                  );
                },
              ),
              RaisedButton(
                child: Text("Reject Connection"),
                onPressed: () async {
                  Navigator.pop(context);
                  try {
                    await Nearby().rejectConnection(id);
                  } catch (e) {
                    showSnackbar(e);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
