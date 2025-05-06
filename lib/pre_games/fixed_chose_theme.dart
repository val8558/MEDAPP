import 'package:flutter/material.dart';
import 'package:medapp/pre_games/chose_theme.dart';

class FixedChoseTheme extends StatelessWidget{
  const FixedChoseTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return ChoseTheme(
      type: 'fixed',
      title: 'QUIZ FIXO',
      image: Image.asset(
        'assets/fixed_quiz.png',
        height: 120,
        alignment: Alignment.centerRight,
      ),
    );
  }
}