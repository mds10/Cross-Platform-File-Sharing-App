class SaveData {
  String fileName;
  String whichSide;
  String dateTime;
  String otherUserId;

  SaveData({this.fileName, this.whichSide, this.dateTime, this.otherUserId});

  SaveData.fromMap(Map map) {
    this.fileName = map["fileName"];
    this.whichSide = map["whichSide"];
    this.dateTime = map["dateTime"];
    this.otherUserId = map["otherUserId"];
  }
  Map toMap() {
    return ({
      "fileName": this.fileName,
      "whichSide": this.whichSide,
      "dateTime": this.dateTime,
      "otherUserId": this.otherUserId,
    });
  }
}
