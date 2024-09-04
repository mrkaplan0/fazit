import 'package:fazit/models/file_model.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({super.key, required this.myFile});
  final MyFile myFile;
  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late PdfController pdfController;

  @override
  void initState() {
    super.initState();
    pdfController = PdfController(
      document: PdfDocument.openFile(widget.myFile.path!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text(widget.myFile.fileName!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PdfView(
          controller: pdfController,
          onDocumentError: (error) => showDialog(
            context: context,
            builder: (context) => const AlertDialog.adaptive(
              title: Text("Error"),
            ),
          ),
        ),
      ),
    );
  }
}
