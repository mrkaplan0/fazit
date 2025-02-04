import 'package:flutter/material.dart';

const myBigTitleSize = 40.0;

const myBigTitleTextStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: myBigTitleSize);

const myLittleTitleTextStyle = TextStyle(fontWeight: FontWeight.bold);
var myIconbuttonStyle = ButtonStyle(
    shadowColor:
        WidgetStatePropertyAll(Colors.purple.shade700.withValues(alpha: 0.8)),
    elevation: WidgetStateProperty.all<double>(1.5));

var myIconButtonHoverColor = Colors.purple.shade400;
const activeButtonColorLight = Color(0xFFF56D91);
const activeButtonColorDark = Color(0xFF8D8DAA);
const nonActiveButtonColorLight = Color(0xFFF7F5F2);
const nonActiveButtonColorDark = Color(0xFFDFDFDE);
const scaffoldBackgroundColor = Colors.white;
const appBarBackgroundColor = Colors.white;
const cardColorLight = Color(0xFFF7F5F2);
const cardColorDark = Color(0xFF8D8DAA);

var appBarLogoWidget = Image.asset("assets/fazit_text.png", height: 35);

final List<String> learnThemes = [
  "Allegemein",
  "Unternehmen",
  "Arbeitsplatz",
  "Clientsnetzwerke",
  "Schutzbedarfanalyse",
  "Verwaltungssoftware",
  "Serviceanfragen",
  "Cybersysteme",
  "Daten",
  "Netzwerke und Dienste",
  "Python",
  "SQL-Datenbanksprache",
  "Git-Befehle"
];
