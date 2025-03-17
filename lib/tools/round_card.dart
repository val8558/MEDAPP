import 'package:flutter/material.dart';

class RoundCard extends StatelessWidget {
  final Color color;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final BorderRadius border;
  final Widget child;
  const RoundCard({
      this.color = Colors.white,
      this.margin = const EdgeInsets.all(10),
      this.padding = const EdgeInsets.all(15),
      this.border = const BorderRadius.all(
        Radius.circular(30)
      ),
      required this.child,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
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