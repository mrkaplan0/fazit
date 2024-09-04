import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnimatedSwitcherWidget extends StatefulWidget {
  int duration;
  Widget widget1;
  Widget? widget2;
  int? delayedDuration = 3;

  AnimatedSwitcherWidget(
      {super.key,
      required this.duration,
      required this.widget1,
      this.widget2,
      this.delayedDuration});

  @override
  State<AnimatedSwitcherWidget> createState() => _AnimatedSwitcherWidgetState();
}

class _AnimatedSwitcherWidgetState extends State<AnimatedSwitcherWidget> {
  bool isVisible = true;
  @override
  void initState() {
    super.initState();

    changeWidget();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: Duration(seconds: widget.duration),
        child: isVisible ? widget.widget1 : widget.widget2);
  }

  changeWidget() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isVisible = !isVisible;
    });
  }
}
