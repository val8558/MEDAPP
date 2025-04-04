import 'package:flutter/material.dart';
import 'package:medapp/models/question_data.dart';
import 'package:medapp/server_manager.dart';
import 'package:medapp/tools/round_card.dart';

class Quiz extends StatefulWidget {
  final bool infinite;
  final String theme;
  const Quiz({
    required this.infinite,
    this.theme = '',
    super.key
  });

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<QuestionData> questions = [];
  QuestionData? question;

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

    Column body(){
      if(questions.isEmpty){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.question_mark, size: 100),
            const SizedBox(height: 20),
            Text(
              "Nenhuma questão encontrada",
              style: textTheme.titleMedium?.copyWith(
                fontSize: 20
              )
            )
          ],
        );
      }

      question ??= questions.first;
      int index = questions.indexOf(question!);
      List<RoundCard> answers = [];
      for(var element in question!.answers){
        answers.add(answerCard(element));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          super.widget.infinite? lifeRemain(): timeRemain(),
          const SizedBox(height: 20),
          RoundCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Questão ${index+1}",
                  style: textTheme.titleSmall?.copyWith(
                    fontSize: 16
                  )
                ),
                const SizedBox(height: 30),
                Text(
                  question!.question,
                  style: textTheme.bodyMedium
                ),
              ],
            )
          ),
          Column(
            children: answers,
          ),
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
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: questions.isNotEmpty
          ? body()
          : FutureBuilder(
            future: ServerManager.getQuestionsData(
              theme: super.widget.theme,
            ),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator()
                );
              }

              if(snapshot.hasError){
                return Center(
                  child: Text("Erro: ${snapshot.error}"),
                );
              }

              questions = snapshot.data!;
              question = questions.first;
              return body();
            },
          )
        )
      )
    );
  }
}