import 'package:flutter/material.dart';

class ContainerProgressIndicator extends StatefulWidget {
  const ContainerProgressIndicator({super.key, this.width, this.height});
  final double? width;
  final double? height;
  @override
  ContainerProgressIndicatorState createState() =>
      ContainerProgressIndicatorState();
}

class ContainerProgressIndicatorState extends State<ContainerProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _borderColorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _borderColorAnimation = ColorTween(
      begin: const Color.fromARGB(0, 86, 91, 212),
      end: const Color.fromARGB(255, 201, 229, 245),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          width: widget.width ?? 150,
          height: widget.height ?? 150,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _borderColorAnimation.value ?? Colors.blue,
              width: 2,
            ),
          ),
          child: Image.asset(
            "assets/fazit_text.png",
          ),
        );
      },
    );
  }
}
