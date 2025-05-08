import 'package:flutter/material.dart';

class LifeRemain extends StatelessWidget {
  final int life;
  const LifeRemain({required this.life, super.key});

  @override
  Widget build(BuildContext context) {
    Image lifeIcon(bool isActive){
      return Image.asset(
        isActive? 'assets/heart.png': 'assets/heart_fill.png',
        height: 40,
      );
    }

    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          children: [
            lifeIcon(life > 0),
            const SizedBox(width: 5),
            lifeIcon(life > 1),
            const SizedBox(width: 5),
            lifeIcon(life > 2),
          ],
        )
      );
  }
}