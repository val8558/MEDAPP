import 'package:flutter/widgets.dart';
import 'package:medapp/pre_games/chose_theme.dart';

class TrailChoseTheme extends StatelessWidget {
  const TrailChoseTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return ChoseTheme(
      type: 'track',
      title: 'MODO TRILHA',
      image: Image.asset(
        'assets/trail_mode.png',
        height: 120,
        alignment: Alignment.centerRight,
      ),
    );
  }

}