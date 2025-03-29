import 'package:flutter/material.dart';
import 'package:medapp/tools/round_card.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // ignore: unused_local_variable
    TextTheme textTheme = Theme.of(context).textTheme;

    Image lifeIcon(bool isActive){
      return Image.asset(
        isActive? 'assets/heart.png': 'assets/heart_fill.png',
        height: 40,
      );
    }

    Widget lifeRemain(){
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          children: [
            lifeIcon(true),
            const SizedBox(width: 5),
            lifeIcon(true),
            const SizedBox(width: 5),
            lifeIcon(false),
          ],
        )
      );
    }

    Widget timeRemain(){
      return Column(
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 10,
              thumbColor: Colors.transparent,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0)
            ),
            child: Slider(
              value: 50,
              max: 100,
              min: 0,
              activeColor: colorScheme.primary,
              inactiveColor: Colors.white,
              onChanged: (double value) {},
            ),
          ),
          Text(
            "00:53",
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
            )
          ),
        ],
      );
    }

    RoundCard answerCard(String answer){
      return RoundCard(
        padding: const EdgeInsets.fromLTRB(20,15,20,15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.circle,
              color: Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                answer,
                style: textTheme.titleSmall?.copyWith(
                  fontSize: 16
                )
              )
            )
          ],
        )
      );
    }
    bool isTimeType = false;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              isTimeType? timeRemain(): lifeRemain(),
              const SizedBox(height: 20),
              RoundCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Questão 1",
                      style: textTheme.titleSmall?.copyWith(
                        fontSize: 16
                      )
                    ),
                    const SizedBox(height: 30),
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", 
                      style: textTheme.bodyMedium
                    ),
                  ],
                )
              ),
              answerCard("Resposta A"),
              answerCard("Resposta B"),
              answerCard("Resposta C"),
              answerCard("Resposta D"),

              Padding(
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
                ),  
              )
            ],
          ),
        )
      )
    );
  }
}