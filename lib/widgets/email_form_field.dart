import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  final String _emailLabelText = "Email";
  final String _emailHintText = 'Email eingeben.';
  final String _canNotNilText = "Dieses Feld darf nicht leer bleiben.";
  final String _invalidMail = "Ungültige E-Mail-Adresse";
  const EmailFormField(
      {super.key,
      this.focusNode,
      this.focusNode2,
      required this.context,
      required this.textEditingController});
  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final FocusNode? focusNode2;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          labelText: _emailLabelText,
          hintText: _emailHintText,
          suffixIcon: const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.mail_outline_rounded),
          )),
      validator: (String? mail) {
        if (mail == "") {
          return _canNotNilText;
        } else {
          if (!mail!.contains("@")) {
            return _invalidMail;
          }
        }
        return null;
      },
      onFieldSubmitted: (value) {
        focusNode2?.unfocus();
      },
    );
  }
}
