class Cloudfile {
  String File_name;
  String LUri;
  String Key;

  Cloudfile({this.File_name, this.LUri, this.Key});

  String name() {
    return this.File_name;
  }

  @override
  String toString() {
    // TODO: implement toString
    return this.File_name + " " + this.LUri;
  }
}
