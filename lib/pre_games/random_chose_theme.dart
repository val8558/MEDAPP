import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:medapp/models/question_theme_data.dart';
import 'package:medapp/pre_games/default_theme.dart';
import 'package:medapp/tools/round_card.dart';

class RandomChoseTheme extends DefaultTheme {
  const RandomChoseTheme({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // ignore: unused_local_variable
    TextTheme textTheme = Theme.of(context).textTheme;

    return super.baseBody(
      context: context,
      title: "QUIZ ALEATÓRIO",
      subTitle: defaultTxt,
      image: Image.asset(
        'assets/random_quiz.png',
        height: 120,
        alignment: Alignment.centerRight,
      ),
      body: const RandomBody(),
    );
  }
}

class RandomBody extends StatefulWidget {
  const RandomBody({super.key});

  @override
  State<RandomBody> createState() => _RandomBodyState();
}

class _RandomBodyState extends State<RandomBody> {
  late int timeRemaining;
  Timer? timer;
  int interval = 500;
  int index = -1;
  bool started = false;

  void selectTheme(){
    Navigator.pushNamed(
      context, 
      '/quiz',
      arguments: {
        'type': TypeGame.run,
        'theme': ""
      }
    );
  }

  void startTimer() {
    timer = Timer.periodic(
      Duration(milliseconds: interval),
      (Timer t) {
        if (timeRemaining > 0) {
          setState(() {
            timeRemaining--;
            interval = max(100, interval - 100);

            index++;
            if(index > 3) index = 0;
          });
          
          t.cancel();
          startTimer();
        } else {
          t.cancel();
          selectTheme();
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // ignore: unused_local_variable
    TextTheme textTheme = Theme.of(context).textTheme;
    double margin = 10;
    double cardWidth = (MediaQuery.of(context).size.width /2) - 20;

    if(cardWidth < 180) cardWidth = 180;
    if(cardWidth > 350) cardWidth = 350;

    RoundCard themeCard({
      required String theme,
      required int index,
      double left = 0,
      double top = 0,
      double right = 0,
      double bottom = 0
    }){
      Color bg = this.index == index
        ? colorScheme.secondary
        :Colors.white;
      
      Color txt = this.index == index
        ? Colors.white
        : Colors.black;

      return RoundCard(
          margin: EdgeInsets.fromLTRB(left, top, right, bottom),
          width: cardWidth,
          height: 150,
          color: bg,
          child: Center(
            child: Text (
              theme,
              style: textTheme.titleSmall
              ?.copyWith(
                color: txt
              ),
              textAlign: TextAlign.center,
            ),
          )
        );
    }

    return Column(
      children: [
        Wrap(
          children: [
            themeCard(
              theme: "tema 1 do quiz aleatório",
              index: 0,
              right: margin,
              bottom: margin
            ),
            themeCard(
              theme: "tema 2 do quiz aleatório",
              index: 1,
              left: margin,
              bottom: margin
            ),
            themeCard(
              theme: "tema 3 do quiz aleatório",
              index: 3,
              right: margin,
              top: margin
            ),
            themeCard(
              theme: "tema 4 do quiz aleatório",
              index: 2,
              left: margin,
              top: margin
            ),
          ],
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: cardWidth * 2,
          height: 50,
          child: TextButton(
            onPressed: (){
              if(started) return;

              started = true;
              index = Random().nextInt(4);
              timeRemaining = Random().nextInt(6) + 5;
              startTimer();
            },
            child: Text("Começar")
          )
        )
      ],
    );
  }
}