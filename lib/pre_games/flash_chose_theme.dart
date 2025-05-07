import 'package:flutter/material.dart';
import 'package:medapp/pre_games/chose_theme.dart';

class FlashChoseTheme extends StatelessWidget{
  const FlashChoseTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return ChoseTheme(
      type: 'flash',
      title: 'FLASHCARDS',
      image: Image.asset(
        'assets/Flashcards.png',
        height: 120,
        alignment: Alignment.centerRight,
      ),
    );
  }
}