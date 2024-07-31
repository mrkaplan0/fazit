import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

enum MenuItemCase { fromLocal, fromUrl }

class BooksMainpage extends StatefulWidget {
  const BooksMainpage({super.key});

  @override
  State<BooksMainpage> createState() => _BooksMainpageState();
}

class _BooksMainpageState extends State<BooksMainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bücher"),
        actions: [
          //IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          PopupMenuButton<MenuItemCase>(
              onSelected: (MenuItemCase selectedItem) async {
                if (selectedItem == MenuItemCase.fromLocal) {
                  //if selection is from Local, select file. then save it local folder of app.
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                          allowedExtensions: ["epub", "pdf"],
                          type: FileType.custom);

                  if (result != null) {
                    File file = File(result.files.single.path!);

                    String? outputFile = await FilePicker.platform.saveFile()
                  } else {
                    // User canceled the picker
                  }
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
      body: const Column(
        children: [],
      ),
    );
  }
}
