import 'package:flutter/material.dart';

class RoundCard extends StatelessWidget {
  final Color color;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final BorderRadius border;
  final double? width, height;
  final Widget child;
  const RoundCard({
      this.color = Colors.white,
      this.margin = const EdgeInsets.all(10),
      this.padding = const EdgeInsets.all(15),
      this.border = const BorderRadius.all(
        Radius.circular(30)
      ),
      this.width,
      this.height,
      required this.child,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: border
      ),
      child: child,
    );
  }
}