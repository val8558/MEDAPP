import 'package:flutter/material.dart';
import 'package:medapp/models/question_theme_data.dart';
import 'package:medapp/quiz/life_remain.dart';
import 'package:medapp/quiz/quiz_body.dart';
import 'package:medapp/quiz/time_remain.dart';

class Quiz extends StatelessWidget {
  final TypeGame typeGame;
  final String theme;
  final int maxAlternative;
  const Quiz({
    required this.typeGame,
    this.theme = '',
    this.maxAlternative = 10000,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // ignore: unused_local_variable
    TextTheme textTheme = Theme.of(context).textTheme;

    ValueNotifier<int> life = ValueNotifier<int>(3);

    final GlobalKey<QuizBodyState> quizBodyKey = GlobalKey<QuizBodyState>();

    Widget defaultFooter() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: TextButton(
          onPressed: null,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            foregroundColor: const WidgetStatePropertyAll(Colors.black),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                "Reportar Erro",
              )
            )
          )
        )
      );
    }

    Widget? header;
    Widget? footer;
    switch (typeGame) {
      case TypeGame.infinite:
        header = ValueListenableBuilder<int>(
          valueListenable: life,
          builder: (context, value, child) {
            return LifeRemain(life: value);
          },
        );
        footer = defaultFooter();
        break;
      case TypeGame.run:
        header = TimeRemain();
        footer = defaultFooter();
        break;
      case TypeGame.flash:
        header = Row(
          children: [
            const SizedBox(width: 15),
            TextButton(
              onPressed: null,
              child: Text("FLASHCARD")
            )
          ],
        );

        ButtonStyle style = ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          foregroundColor: const WidgetStatePropertyAll(Colors.black),
        );

        footer = Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  quizBodyKey.currentState?.previousQuestion();
                },
                style: style,
                child: const Text("Voltar"),
              ),
              TextButton(
                onPressed: () {
                  quizBodyKey.currentState?.nextQuestion();
                },
                style: style,
                child: const Text("Próximo"),
              ),
            ],
          ),
        );
        break;
      default:
        header = null;
        break;
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              if (header != null) header,
              QuizBody(
                key: quizBodyKey,
                typeGame: typeGame,
                theme: theme,
                maxAlternative: maxAlternative,
                life: typeGame == TypeGame.infinite ? life : null,
              ),
              if (footer != null) footer,
            ],
          ),
        ),
      ),
    );
  }
}