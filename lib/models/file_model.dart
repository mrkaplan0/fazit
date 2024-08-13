import 'dart:io';

import 'package:path/path.dart' as p;

class MyFile {
  FileSystemEntity? fileEntity;
  String? fileName;
  String? extension;
  String? path;

  MyFile({this.fileEntity, this.path}) {
    File myFile;
    if (fileEntity != null) {
      myFile = fileEntity as File;
      path = myFile.path;
    } else {
      myFile = File(path!);
    }

    fileName = p.basenameWithoutExtension(myFile.path);
    extension = p.extension(myFile.path);
  }
  getFile() {
    if (path != null) {
      return File(path!);
    } else {
      return null;
    }
  }

  @override
  String toString() {
    return "fileName $fileName $extension $path ";
  }
}
