import 'dart:math' as math;

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
          width: width / 2 - 20,
          height: width / 2 - 20,
          decoration: BoxDecoration(
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(0.7),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: width / 6,
                color: Colors.white70,
              ),
              Text(
                text,
                style: const TextStyle(color: Colors.white70, shadows: [
                  Shadow(
                      blurRadius: 0.0,
                      offset: Offset(1, 1),
                      color: Colors.black12)
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
