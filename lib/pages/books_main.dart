import 'dart:io';
import 'package:fazit/models/file_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../widgets/file_list_widget.dart';

enum MenuItemCase { fromLocal, fromUrl }

class BooksMainpage extends StatefulWidget {
  const BooksMainpage({super.key});

  @override
  State<BooksMainpage> createState() => _BooksMainpageState();
}

class _BooksMainpageState extends State<BooksMainpage> {
  late Directory booksDirectory;
  List allFilesFromDic = [];
  List<MyFile> epubFiles = [];
  List<MyFile> pdfFiles = [];
  @override
  void initState() {
    super.initState();
    _listofFiles();
  }

  // Make New Function
  void _listofFiles() async {
    epubFiles.clear();
    pdfFiles.clear();
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
    for (var e in allFilesFromDic) {
      MyFile myFile = MyFile(fileEntity: e);

      if (myFile.extension == ".epub") {
        epubFiles.add(myFile);
      } else if (myFile.extension == ".pdf") {
        pdfFiles.add(myFile);
      }
    }
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              myDivider("e-Books"),
              ListWidget(title: "Epubs", filesList: epubFiles),
              const SizedBox(
                height: 20,
              ),
              myDivider("pdfs"),
              ListWidget(title: "pdfs", filesList: pdfFiles),
            ],
          ),
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
      setState(() {
        _listofFiles();
      });
    } else {
      // User canceled the picker
    }
  }
}

Widget myDivider(String title) {
  return Column(
    children: [
      Text(title),
      const Divider(),
    ],
  );
}
