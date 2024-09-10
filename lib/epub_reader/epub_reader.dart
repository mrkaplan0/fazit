import 'package:fazit/epub_reader/chapter_drawer.dart';
import 'package:fazit/epub_reader/search_page.dart';
import 'package:fazit/models/file_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epub_viewer/flutter_epub_viewer.dart';

class EpubReader extends StatefulWidget {
  const EpubReader({super.key, required this.myFile});

  final MyFile myFile;

  @override
  State<EpubReader> createState() => _EpubReaderState();
}

class _EpubReaderState extends State<EpubReader> {
  final epubController = EpubController();
  var textSelectionCfi = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ChapterDrawer(
        controller: epubController,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.myFile.fileName ?? ""),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchPage(
                            epubController: epubController,
                          )));
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: EpubViewer(
              epubSource: EpubSource.fromAsset("assets/buch.epub"),
              epubController: epubController,
              displaySettings: EpubDisplaySettings(
                  flow: EpubFlow.paginated,
                  snap: true,
                  allowScriptedContent: true),
              selectionContextMenu: ContextMenu(
                menuItems: [
                  ContextMenuItem(
                    title: "Highlight",
                    id: 1,
                    action: () async {
                      epubController.addHighlight(cfi: textSelectionCfi);
                      print("lkjafhdsölkfhsölhj $textSelectionCfi");
                    },
                  ),
                  ContextMenuItem(
                    title: "Remove Highlight",
                    id: 2,
                    action: () async {
                      epubController.removeHighlight(cfi: textSelectionCfi);
                    },
                  )
                ],
                settings: ContextMenuSettings(
                    hideDefaultSystemContextMenuItems: true),
              ),
              onChaptersLoaded: (chapters) {},
              onEpubLoaded: () async {
                print('Epub loaded');
              },
              onRelocated: (value) {
                print("Reloacted to $value");
              },
              onTextSelected: (epubTextSelection) {
                textSelectionCfi = epubTextSelection.selectionCfi;
                print(textSelectionCfi);
              },
            ),
          ),
        ],
      )),
    );
  }
}
