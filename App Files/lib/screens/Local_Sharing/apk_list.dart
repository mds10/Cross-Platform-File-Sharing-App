import 'package:device_apps/device_apps.dart';
import 'dart:async';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:ShareApp/screens/Local_Sharing/paths_data.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class ApkExtractor extends StatefulWidget {
  ApkExtractor(){}
  @override
  _ApkExtractorState createState() => _ApkExtractorState();
}

class _ApkExtractorState extends State<ApkExtractor>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<Application> list = new List<Application>();
  GlobalKey g1 = new GlobalKey();
  TextEditingController tcont = new TextEditingController();
  String searchText = "";
  Data pdata=new Data();
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    pdata.path={};
  }
  _ApkExtractorState() {
    tcont.addListener(() {
      if (isSearching) {
        setState(() {
          searchText = tcont.text;
        });
      }
    });
  }
  generateApk(String path1, String name, MemoryImage img) async {
    File f1 = new File(path1); // await UninstallApps
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'ApkExtractor', name);
    Directory n = Directory(path);
    bool dec = await n.exists();
    if (dec == false) {
      await n.create();
    }
    f1.copy('/storage/emulated/0/$name.apk');
    f1.copy(join(path, 'setup.apk'));
    File image = new File(join(path, 'image.jpeg'));
    image.writeAsBytesSync(img.bytes);
    // print(g1.currentWidget);
    setState(() {});
  }

  getArchieved() async {
    // print("Coming at get Archeived");
    Directory dir = await getApplicationDocumentsDirectory();
    print(dir);
    String path = join(dir.path, 'ApkExtractor');
    print(path);

    Directory n = Directory(path);
    bool dec = await n.exists();
    if (dec == false) {
      n.create();
    }
    return n.listSync();
  }

  getList(li, context) {
    if (isSearching == false) list = li;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: li.length,
        itemBuilder: (context, index) {
          Application app = li[index];

          ListTile tile = ListTile(
              leading: app is ApplicationWithIcon
                  ? CircleAvatar(
                backgroundImage: MemoryImage(app.icon),
              )
                  : null,
              title: Text(li[index].appName),
              subtitle: Text(li[index].versionName),
              onTap: () async {
                bool isInstalled =
                await DeviceApps.isAppInstalled(app.packageName);
                if (isInstalled == false) {
                  setState(() {
                    li.clear();
                    list.clear();
                  });
                } else {
                  MemoryImage img;
                  app is ApplicationWithIcon
                      ? img = MemoryImage(app.icon)
                      : null;
                  // print("on tap pressed");
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Container(
                                margin: EdgeInsets.all(10),
                                height: 350,
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.arrow_left),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                iconSize: 30,
                                              ),
                                              Center(
                                                  child: Text("Choose Option",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight.bold))),
                                            ],
                                          )),
                                      SizedBox(height: 20),
                                      FlatButton.icon(
                                          icon: Icon(Icons.share),
                                          label: Text("Share Apk",
                                              textAlign: TextAlign.left),
                                          onPressed: () async {
                                            pdata.path.addAll({app.appName:app.apkFilePath});
                                            print(app.appName+" "+app.apkFilePath);
                                            Navigator.pop(context);
                                            Navigator.pop(context,pdata);
                                          }),
                                      FlatButton.icon(
                                          icon: Icon(Icons.android),
                                          label: Text(
                                            "Generate Apk",
                                            textAlign: TextAlign.left,
                                          ),
                                          onPressed: () => generateApk(
                                              app.apkFilePath,
                                              app.appName,
                                              img)),

                                      FlatButton.icon(
                                          icon: Icon(Icons.info),
                                          label: Text("App Info",
                                              textAlign: TextAlign.left),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            showAboutDialog(
                                                context: context,
                                                applicationName: app.appName,
                                                children: [
                                                  Container(
                                                      child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text("Package Name  " +
                                                                app.packageName),
                                                            Text("Apk Path  " +
                                                                app.apkFilePath),
                                                            Text(
                                                                "Data Directory  " +
                                                                    app.dataDir),
                                                            Text("Version Name  " +
                                                                app.versionName),
                                                            Text("Version Code  " +
                                                                app.versionCode
                                                                    .toString()),
                                                          ]))
                                                ]);
                                          }),
                                    ]
                                )
                            )
                        );
                      });
                }
              });
          return tile;
        });
  }

  bool isSearching = false;

  Future<dynamic> workaround() async {
    List<Application> newlist = new List<Application>();
    for (int i = 0; i < list.length; i++) {
      Application app = list[i];
      if (app.appName.toLowerCase().startsWith(searchText)) newlist.add(app);
    }
    return newlist;
  }

  Future<dynamic> letsdo() async {
    var status = Permission.storage;
    var bl = await status.isUndetermined;
    if (bl == true) {
      await status.request();
    }

    if (list.length == 0) {
      return DeviceApps.getInstalledApplications(
          includeAppIcons: true,
          includeSystemApps: false,
          onlyAppsWithLaunchIntent: false);
    } else {
      // print("Coming Heeeeeere");
      return workaround();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuilding Agian");
    return Scaffold(
        appBar: AppBar(
          elevation: 3.0,
          backgroundColor: Colors.blue,
          title: isSearching
              ? TextField(
            autofocus: true,
            controller: tcont,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.white),
              hintText: "Search...",
            ),
          )
              : Text(
            "Apk Extractor",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: isSearching
                  ? Icon(Icons.close, color: Colors.white)
                  : Icon(Icons.search, color: Colors.white),
              onPressed: () {
                setState(() {
                  if (isSearching) {
                    searchText = "";
                    tcont.text = "";
                    isSearching = false;
                  } else
                    isSearching = true;
                });
              },
            )
          ],
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.red,
            indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            tabs: <Widget>[
              Container(
                  height: 40,
                  alignment: Alignment.center,
                  width: 110,
                  child: Text("Installed")),
              Container(
                  height: 40,
                  alignment: Alignment.center,
                  width: 110,
                  child: Text("Extracted Apks")),
            ],
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          Container(
              child: FutureBuilder(
                  future: letsdo(),
                  builder: (context, data) {
                    if (data.data == null || data.data.length == 0) {
                      print("Coming in If");
                      return Center(child: CircularProgressIndicator());
                    } else {
                      print("Coming in Else");
                      List<Application> li = data.data;
                      return getList(li, context);
                    }
                  })),
          Container(
            // color: Colors.green,
              child: FutureBuilder(
                  future: getArchieved(),
                  builder: (context, data) {
                    if (data.data != null) {
                      List<dynamic> li = data.data;
                      return ListView.builder(
                          key: g1,
                          itemCount: li.length,
                          itemBuilder: (context, index) {
                            String name = basename(li[index].path);
                            if (li[index] is Directory &&
                                name.toLowerCase().startsWith(searchText)) {
                              return InkWell(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30)),
                                            child: Container(
                                                margin: EdgeInsets.all(10),
                                                height: 350,
                                                child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              IconButton(
                                                                icon: Icon(Icons.arrow_left),
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                iconSize: 30,
                                                              ),
                                                              Center(
                                                                  child: Text("Choose Option",
                                                                      style: TextStyle(
                                                                          color: Colors.grey,
                                                                          fontSize: 20,
                                                                          fontWeight:
                                                                          FontWeight.bold))),
                                                            ],
                                                          )),
                                                      SizedBox(height: 20),
                                                      FlatButton.icon(
                                                          icon: Icon(Icons.share),
                                                          label: Text("Share Apk",
                                                              textAlign: TextAlign.left),
                                                          onPressed: () async {
                                                            print(name+" "+join(li[index].path, 'setup.apk').toString());
                                                            pdata.path={};
                                                            pdata.path.addAll({name:join(li[index].path, 'setup.apk')});
                                                            Navigator.pop(context);
                                                            Navigator.pop(context,pdata);
                                                          }),
                                                      FlatButton.icon(
                                                          icon: Icon(Icons.download_done_outlined),
                                                          label: Text(
                                                            "Download Apk",
                                                            textAlign: TextAlign.left,
                                                          ),
                                                          onPressed: () async {
                                                            Navigator.pop(context);
                                                            await OpenFile.open(
                                                                join(li[index].path, 'setup.apk'))
                                                                .then((OpenResult value) {});
                                                            print("File Opened");
                                                          }),
                                                    ]
                                                )
                                            )
                                        );
                                      });
                                  /*await OpenFile.open(
                                      join(li[index].path, 'setup.apk'))
                                      .then((OpenResult value) {});
                                  print("File Opened");*/
                                },
                                child: ListTile(
                                  title: Text(name),
                                  leading: CircleAvatar(
                                      backgroundImage: FileImage(File(
                                          join(li[index].path, 'image.jpeg')))),
                                ),
                              );
                            } else
                              return Container();
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })),
        ]));
  }
}
