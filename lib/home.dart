import 'package:flutter/material.dart';
import 'package:medapp/tools/all_text.dart';
import 'package:medapp/tools/round_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    Container dayCard(String day, String number, {bool active = false}){
      Color bgColor = active ? colorScheme.secondary : Colors.white;
      Color txtColor = active ? Colors.white : colorScheme.secondary;

      return Container(
        width: 40,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(15)
          ),
          border: Border.all(
            color: colorScheme.secondary,
            width: 1
          )
        ),
        child: Column(
          children: [
            Text(
              day,
              style: textTheme.labelMedium?.copyWith(
                color: txtColor
              )
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
              ),
              child: Text(
                number,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold
                )
              )
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              RoundCard(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 15),
                border: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)
                ),
                child: Row(
                  children: [
                    const Icon(Icons.person_2_sharp, size: 40),
                    Text(HomeText.hello, style: textTheme.titleMedium)
                  ],
                ),
              ),
              RoundCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hoje, 22 Agosto 2024", style: textTheme.titleSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dayCard("Seg", "19", active: true),
                        dayCard("Ter", "20"),
                        dayCard("Qua", "21"),
                        dayCard("Qui", "22", active: true),
                        dayCard("Sex", "23"),
                        dayCard("Sab", "24"),
                        dayCard("Dom", "25"),
                      ]
                    )
                  ],
                )
              ),
              RoundCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: HomeText.quiz,
                            style: textTheme.titleSmall?.copyWith(
                              fontSize: 18
                            ),
                            children: [
                              TextSpan(
                                text: "\n${HomeText.subQuiz}",
                                style: textTheme.labelMedium
                              ),
                            ]
                          ),
                        ),
                        const SizedBox(height: 15),                  
                        TextButton(
                          onPressed: ()=> Navigator.pushNamed(context, '/choseTheme'),
                          child: Text(HomeText.buttonQuiz)
                        )
                      ],
                    ),
                    Image.asset(
                      'assets/fixed_quiz.png',
                      height: 120,
                      alignment: Alignment.centerRight,
                    ),
                  ],
                )
              )
            ],
          ),
        )
      )
    );
  }
}