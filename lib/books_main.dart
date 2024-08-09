import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

enum MenuItemCase { fromLocal, fromUrl }

class BooksMainpage extends StatefulWidget {
  const BooksMainpage({super.key});

  @override
  State<BooksMainpage> createState() => _BooksMainpageState();
}

class _BooksMainpageState extends State<BooksMainpage> {
  late Directory booksDirectory;
  List allFilesFromDic = [];
  @override
  void initState() {
    super.initState();
    _listofFiles();
  }

  // Make New Function
  void _listofFiles() async {
    //get app directory
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    booksDirectory = Directory('${appDocumentsDir.path}/books');
    // create folder if not exists
    if (!await booksDirectory.exists()) {
      await booksDirectory.create(recursive: true);
    }

    setState(() {
      allFilesFromDic = booksDirectory.listSync();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bücher"),
          actions: [
            PopupMenuButton<MenuItemCase>(
                onSelected: (MenuItemCase selectedItem) async {
                  if (selectedItem == MenuItemCase.fromLocal) {
                    //if selection is from Local, select file. then save it local folder of app.
                    await getFileFromLocal();
                  } else {}
                },
                icon: const Icon(Icons.add),
                itemBuilder: (context) => <PopupMenuEntry<MenuItemCase>>[
                      const PopupMenuItem<MenuItemCase>(
                        value: MenuItemCase.fromLocal,
                        child: Text('Von lokal hinzufügen'),
                      ),
                      const PopupMenuItem<MenuItemCase>(
                        value: MenuItemCase.fromUrl,
                        child: Text('mit Url herunterladen'),
                      ),
                    ])
          ],
        ),
        body: ListView.builder(
          itemCount: allFilesFromDic.length,
          itemBuilder: (context, i) {
            var myFile = allFilesFromDic[i] as File;
            String extension = p.extension(myFile.path);
            String fileName = p.basenameWithoutExtension(myFile.path);

            return Column(
              children: [
                Text(fileName),
                Text(extension),
              ],
            );
          },
        ));
  }

  Future<void> getFileFromLocal() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowedExtensions: ["epub", "pdf"], type: FileType.custom);

    if (result != null) {
      File file = File(result.files.single.path!);
      String fileName = file.path.split('/').last;

      // save file to the new folder
      final path = '${booksDirectory.path}/$fileName';
      final localFile = await File(path).create();
      await localFile.writeAsBytes(await file.readAsBytes());
      print('Dosya yerel depolamaya kaydedildi: $path');
    } else {
      // User canceled the picker
    }
  }
}
