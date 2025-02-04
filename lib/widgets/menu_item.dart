import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final GestureTapCallback onPress;

  const MenuItem(
      {super.key,
      required this.text,
      required this.icon,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onPress,
        child: Container(
          width: width > 860 ? width / 7 : width / 2 - 20,
          height: width > 860 ? width / 7 : width / 2 - 20,
          decoration: BoxDecoration(
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: width > 860 ? width / 12 : width / 5,
                color: Colors.white70,
              ),
              AutoSizeText(
                width > 860 ? text : shortenText(text, 16),
                style: TextStyle(
                  fontSize: width > 860 ? 16 : 14,
                  color: Colors.white70,
                  shadows: const [
                    Shadow(
                        blurRadius: 0.0,
                        offset: Offset(1, 1),
                        color: Colors.black12)
                  ],
                ),
                minFontSize: 8,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
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
