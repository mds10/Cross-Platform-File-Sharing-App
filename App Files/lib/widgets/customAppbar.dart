import 'package:flutter/material.dart';
import 'package:ShareApp/constants/color_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:ShareApp/screens/Local_Sharing/ftpServer.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomAppBars {
  int _index;
  CustomAppBars({int index}) {
    this._index = index;
  }

  toReloadSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.reload();
  }

  toClearSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('check');
  }

  AppBar getAppBar(context) {
    if (this._index == 0) {
      return AppBar(
        // backgroundColor: Colors.white,
          title: Text('Local Sharing'),
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Colors.white),
          actions: <Widget>[
      IconButton(
      icon: Icon(Icons.computer_outlined),
    onPressed:() async {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        print("permission not granted 1.0");
        await Permission.storage.request();
      }
    if (await Nearby().checkLocationPermission()) {
    if (await Nearby().checkExternalStoragePermission()) {
    if (await Nearby().checkLocationEnabled()) {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => sharing("recieve",userName)));
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => ftpServer()));
    } else {
    if (await Nearby().enableLocationServices()) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => ftpServer()));
    }
    }
    } else {
    Nearby().askExternalStoragePermission();
    if (await Nearby().checkLocationEnabled()) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => ftpServer()));
    } else {
    if (await Nearby().enableLocationServices()) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => ftpServer()));
    }
    }
    }
    } else {
    if (await Nearby().askLocationPermission()) {
    if (await Nearby().checkExternalStoragePermission()) {
    if (await Nearby().checkLocationEnabled()) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => ftpServer()));
    } else {
    if (await Nearby().enableLocationServices()) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => ftpServer()));
    }
    }
    } else {
    Nearby().askExternalStoragePermission();
    if (await Nearby().checkLocationEnabled()) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>ftpServer()));
    } else {
    if (await Nearby().enableLocationServices()) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => ftpServer()));
    }
    }
    }
    }
    }
    }),
    ],
    );
    } else if (this._index == 2) {
    return AppBar(
    backgroundColor: mBlueColor,
    elevation: 0,
    title: Text('History'),
    iconTheme: new IconThemeData(color: Colors.white),
    );
    } else if (this._index == 3) {
    return AppBar(
    backgroundColor: mBlueColor,
    elevation: 0,
    title: Text('Settings'),
    iconTheme: new IconThemeData(color: Colors.white),
    actions: <Widget>[
//    IconButton(
//    icon: Icon(Icons.notifications),
//    onPressed: () => print('To imple')),
    ],
    );
    }
  }
}
