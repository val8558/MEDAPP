import 'package:flutter/material.dart';
import 'package:medapp/tools/round_card.dart';

class ChoseTheme extends StatelessWidget {
  const ChoseTheme({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // ignore: unused_local_variable
    TextTheme textTheme = Theme.of(context).textTheme;

    RoundCard card(){
      return RoundCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/fixed_quiz.png',
              height: 120,
              alignment: Alignment.centerRight,
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Cirurgia",
                      style: textTheme.titleSmall?.copyWith(
                        fontSize: 18
                      ),
                    ),
                  ),                       
                  TextButton(
                    onPressed: null,
                    child: Text("Jogar")
                  ),
                  TextButton(
                    onPressed: null,
                    child: Text("Jogar")
                  ),
                ],
              ),
            ),
          ],
        )
      );
    }

    return  Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/fixed_quiz.png',
                height: 120,
                alignment: Alignment.centerRight,
              ),
              RoundCard(
                color: colorScheme.primary,
                padding: const EdgeInsets.fromLTRB(15,20,15,20),
                child: RichText(
                  text: TextSpan(
                    text: "QUIZ FIXO\n",
                    style: textTheme.titleSmall?.copyWith(
                      fontSize: 18
                    ),
                    children: [
                      TextSpan(
                        text: "\nBem vindo ao Quiz fixo. Nesta modalidade de jogo você escolherá o tema"
                        " das questões e a dificuldade delas.\n\nEscolha entre os modos infinito ou corrida contra o tempo.",
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ]
                  ),
                ), 
              ),
              card(),
              card(),
              card(),
              card(),
              card(),
            ],
          ),
        )
      )
    );
  }
}