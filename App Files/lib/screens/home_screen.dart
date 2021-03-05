import 'dart:ui';

import 'package:ShareApp/constants/color_constant.dart';
// import 'package:ShareApp/screens/Authentication/Loading.dart';
import 'package:ShareApp/widgets/customAppbar.dart';
import 'package:ShareApp/widgets/showScreen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ShareApp/models/add_history.dart';
// import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List to save data
  // List<SaveData> check = [
  //   // SaveData(fileName: "This is a Just Dummy message", whichSide: "Send", dateTime: "", otherUserId: "i889H"),
  // ];
  // SharedPreferences sharedPreferences;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   loadSP();
  // }

  // // LOADING THE SHARED PREFERENCES
  // void loadSP() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     saveData();
  //   });
  // }

  // // AND SAVING THE DATA TO SHAREDPREFERENCES
  // void saveData() {
  //   List<String> spList = check.map((e) => jsonEncode(e.toMap())).toList();
  //   sharedPreferences.setStringList('check', spList);
  //   setState(() {});
  // }

  // // TO SAVE THE DATA IN check LIST OF SAVEDATA TYPE
  // void appendList(String fileName, String whichSide, String otherUserId) {
  //   DateTime now = DateTime.now();
  //   String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
  //   check.add(
  //     SaveData(
  //         fileName: fileName,
  //         whichSide: whichSide,
  //         dateTime: formattedDate,
  //         otherUserId: otherUserId),
  //   );
  //   saveData();
  // }

  @override
  Widget build(BuildContext context) {
    // appendList("This is a just Dummy message", "Send", "ng67e");
    CustomAppBars appbar = new CustomAppBars(index: this._selectedIndex);
    return Scaffold(
      appBar: appbar.getAppBar(context),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text("MiA3"),
              accountEmail: Text("fetchfrom@firebase.com"),
              currentAccountPicture: new GestureDetector(
                onTap: () => print('To implement This Function'),
                // FUNCTION WHICH CAN BE
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: new Text("MiA3"),
                ),
              ),
            ),
            ListTile(
              title: Text("Local Sharing"),
              leading: Icon(Icons.settings),
              onTap: () => print('To Implement'),
            ),
            ListTile(
              title: Text("Cloud Storage"),
              leading: Icon(Icons.settings),
              onTap: () => print('To Implement'),
            ),
            ListTile(
              title: Text("History"),
              leading: Icon(Icons.settings),
              onTap: () => print('To Implement'),
            ),
            ListTile(
              title: Text("Setting"),
              leading: Icon(Icons.settings),
              onTap: () => print('To Implement'),
            ),
            ListTile(
              title: Text("About"),
              leading: Icon(Icons.question_answer_rounded),
            ),
            ListTile(
              title: Text("Close"),
              leading: Icon(Icons.close_rounded),
              onTap: () => Navigator.of(context).pop(),
            ),
            new Divider(),
            ListTile(
              title: Text("Rate This App"),
              trailing: Icon(Icons.star_rate_rounded),
            ),
          ],
        ),
      ),
      backgroundColor: mBackgroundColor,
      bottomNavigationBar: Container(
        height: 64,
        decoration: BoxDecoration(
          color: mFillColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 15,
                offset: Offset(0, 5))
          ],
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(24),
          //   topRight: Radius.circular(24),
          // ),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud),
              title: Text("CloudStorage"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_toggle_off_outlined),
              title: Text("History"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text("Accounts"),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: mBlueColor,
          unselectedItemColor: mSubtitleColor,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 15,
          showUnselectedLabels: true,
          elevation: 0,
        ),
      ),
      body: ShowScreen(index: _selectedIndex),
    );
  }
}
