import 'dart:io';
import 'package:fazit/epub_reader/epub_reader.dart';
import 'package:fazit/models/file_model.dart';
import 'package:fazit/widgets/menu_item.dart';
import 'package:flutter/widgets.dart';
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
  List<MyFile> epubFiles = [];
  List<MyFile> pdfFiles = [];
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
    for (var e in allFilesFromDic) {
      MyFile myFile = MyFile(fileEntity: e);

      if (myFile.extension == ".epub") {
        epubFiles.add(myFile);
        print("aa" + epubFiles.toString());
      } else if (myFile.extension == ".pdf") {
        pdfFiles.add(myFile);
        print("sssss" + pdfFiles.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bücher"),
          actions: [
            TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EpubReader(title: "title"),
                    )),
                child: const Text("fds")),
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
              ExpansionWidget(title: "Epubs", filesList: epubFiles),
              ExpansionWidget(title: "pdfs", filesList: pdfFiles),
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
      print('Dosya yerel depolamaya kaydedildi: $path');
    } else {
      // User canceled the picker
    }
  }
}

class ExpansionWidget extends StatelessWidget {
  final String title;
  final List<MyFile> filesList;

  const ExpansionWidget(
      {super.key, required this.title, required this.filesList});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: EdgeInsets.all(8),
      initiallyExpanded: true,
      title: Text(title),
      children: [
        Wrap(
          children: [
            for (var file in filesList) ...[
              Container(
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10)),
                width: 100,
                height: 150,
                child: Text(
                  file.fileName!,
                  overflow: TextOverflow.clip,
                ),
              )
            ]
          ],
        )

        /*  ListView.builder(
          shrinkWrap: true,
          itemCount: filesList.length,
          itemBuilder: (context, i) {
            return Container(
              color: Colors.amber,
              width: 50,
              height: 100,
              child: Text(
                filesList[i].fileName!,
                overflow: TextOverflow.clip,
              ),
            );
          },
        ) */
      ],
    );
  }
}
