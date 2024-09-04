import 'dart:math' as math;
import 'package:fazit/epub_reader/epub_reader.dart';
import 'package:fazit/models/file_model.dart';
import 'package:fazit/pdf_reader/pdf_viewer_page.dart';
import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  final String title;
  final List<MyFile> filesList;

  const ListWidget({super.key, required this.title, required this.filesList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: filesList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => title == "pdfs"
                      ? PdfViewerPage(myFile: filesList[index])
                      : EpubReader(myFile: filesList[index]),
                )),
            child: Column(
              children: [
                Icon(
                  Icons.book_rounded,
                  size: 160,
                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(0.7),
                ),
                Text(
                  shortenText(filesList[index].fileName!, 20),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String shortenText(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    } else {
      return text;
    }
  }
}
