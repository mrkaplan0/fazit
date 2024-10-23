import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class MyTextWidget extends StatefulWidget {
  const MyTextWidget({super.key, required this.text});
  final String text;
  @override
  State<MyTextWidget> createState() => _MyTextWidgetState();
}

class _MyTextWidgetState extends State<MyTextWidget> {
  final QuillController _textController = QuillController.basic();

  @override
  void initState() {
    super.initState();

    _textController.document = Document.fromJson(jsonDecode(widget.text));
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textController.readOnly = true;

    return QuillEditor.basic(
      controller: _textController,
      configurations: const QuillEditorConfigurations(
          autoFocus: false,
          showCursor: false,
          enableInteractiveSelection: false),
    );
  }
}
