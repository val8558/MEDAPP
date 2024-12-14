import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final LayoutBuilder child;
  const DefaultScaffold({
    required this.child,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: child
    );
  }
}