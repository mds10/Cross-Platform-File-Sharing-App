import 'dart:convert';
import 'dart:io';

import 'package:ShareApp/models/Cloudfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class Storage {
  StorageReference reference = FirebaseStorage.instance.ref();
  StorageReference publicRefMetadata =
      FirebaseStorage.instance.ref().child("Public_Files/metadata.txt");
  CollectionReference publicCollection =
      Firestore.instance.collection('Public');

  // List all public files ..
  Future<List<Cloudfile>> listPublicFiles() async {
    List<Cloudfile> pd = new List();
    await publicCollection
        .where('Key', isEqualTo: "public")
        .snapshots()
        .listen((data) {
      // print(data.documents.length);

      for (int i = 0; i < data.documents.length; i++) {
        Cloudfile p = new Cloudfile();
        p.LUri = data.documents[i].data['File'];
        p.File_name = data.documents[i].data['File_Name'];
        p.Key = data.documents[i].data['Key'];
        pd.add(p);
      }
    });
    return pd;
  }

  Future uploadFileToPublic(
      String File_Name, String path, List<String> tags) async {
    var stamp = DateTime.now().millisecondsSinceEpoch.toString();
    await publicCollection.document(stamp).setData({
      'File_Name': File_Name,
      'File': File_Name + stamp,
      'Key': "public",
      'Tags': tags,
    });
    StorageReference publicUploadRef = reference.child(
        "Public_Files/" + File_Name + stamp); // adding name to metadata.txt
    StorageUploadTask task =
        await publicUploadRef.putFile(File(path)); // adding file to storage
  }

  Future<dynamic> downloadPublicFileWithUrl(String uri) async {
    StorageReference publicDownloadRef = reference.child("Public_Files/" + uri);
    var url = publicDownloadRef.getDownloadURL();
    return url;
  }

  Future<List<Cloudfile>> searchPublicFilesWithTags(String Tag) async {
    List<Cloudfile> pf = new List();
    await publicCollection
        .where("Tags", arrayContains: Tag)
        .snapshots()
        .listen((data) {
      for (int i = 0; i < data.documents.length; i++) {
        Cloudfile p = new Cloudfile(
            File_name: data.documents[i].data['File_Name'],
            LUri: data.documents[i].data['File']);
        pf.add(p);
      }
    });
    return pf;
  }

  //  for private files ..
  CollectionReference privateCollection =
      Firestore.instance.collection('Private');

  Future<List<Cloudfile>> listPrivateFiles(String uid) async {
    List<Cloudfile> pf = new List();
    await privateCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .listen((data) {
      print(data.documents.length);
      for (int i = 0; i < data.documents.length; i++) {
        Cloudfile p = new Cloudfile();
        p.File_name = data.documents[i].data['File_Name'];
        p.LUri = data.documents[i].data['File'];
        p.Key = data.documents[i].data['Key'];
        pf.add(p);
      }
    });
    return pf;
  }

  Future uploadFileToPrivate(String File_Name, String path, String uid) async {
    var stamp = DateTime.now().millisecondsSinceEpoch.toString();
    await privateCollection.document(stamp).setData({
      'uid': uid,
      'File_Name': File_Name,
      'File': File_Name + stamp,
      'Key': uid + ":" + stamp,
    });
    StorageReference privateUploadRef = reference.child("Private_Files/" +
        uid +
        "/" +
        File_Name +
        stamp); // adding name to metadata.txt
    StorageUploadTask task =
        await privateUploadRef.putFile(File(path)); // adding file to sto
  }

  Future<dynamic> downloadPrivateFileWithUrl(String uri, String uid) async {
    StorageReference publicDownloadRef = FirebaseStorage.instance
        .ref()
        .child("Private_Files/" + uid + "/" + uri);
    var url = await publicDownloadRef.getDownloadURL();
    return url;
  }

  String getUid(String key) {
    return key.split(":")[0];
  }

  Future<dynamic> fetchFileFromKey(String key) async {
    String uid = getUid(key);
    String f;
    var url;
    print(uid);
    await privateCollection
        .where("Key", isEqualTo: key)
        .snapshots()
        .listen((data) {
      print("Key is valid");
      print(data.documents.length);
      f = data.documents[0].data['File'];
      print(f);
      StorageReference publicDownloadRef =
          reference.child("Private_Files/" + uid + "/" + f);
      url = publicDownloadRef.getDownloadURL();
    });
    print(url);
    return url;
  }
}
