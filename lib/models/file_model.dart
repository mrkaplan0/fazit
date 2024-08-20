import 'dart:io';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:epub_decoder/epub_decoder.dart';

class MyFile {
  FileSystemEntity? fileEntity;
  String? fileName, author, coverImage;
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
    if (extension == ".epub") {
      getEpubInfo(myFile);
    }
  }
  Future getEpubInfo(File myFile) async {
    final epub = Epub.fromBytes(myFile.readAsBytesSync());

    for (var meta in epub.metadata) {
      if (meta.props.contains("title")) {
        fileName = meta.value;
      } else if (meta.props.contains("creator")) {
        author = meta.value;
      }
    }
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
