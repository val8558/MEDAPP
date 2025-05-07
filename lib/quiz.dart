import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medapp/models/question_data.dart';
import 'package:medapp/models/question_theme_data.dart';
import 'package:medapp/server_manager.dart';
import 'package:medapp/tools/round_card.dart';

class Quiz extends StatefulWidget {
  final TypeGame typeGames;
  final String theme;
  const Quiz({
    required this.typeGames,
    this.theme = '',
    super.key
  });

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<QuestionData> questions = [];
  int index = -1;
  bool answered = false;
  int chosenAnswer = -1;

  // For infinite mode
  int life = 3;
  // For timed mode
  int time = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (widget.typeGames == TypeGame.run) {
      startTimer();
    }
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancele o timer ao sair da tela
    super.dispose();
  }

    void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (time > 0) {
        setState(() {
          time--;
        });
      } else {
        t.cancel();
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    });
  }

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
            lifeIcon(life > 0),
            const SizedBox(width: 5),
            lifeIcon(life > 1),
            const SizedBox(width: 5),
            lifeIcon(life > 2),
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
              value: time.toDouble(),
              max: 60,
              min: 0,
              activeColor: colorScheme.primary,
              inactiveColor: Colors.white,
              onChanged: (double value) {},
            ),
          ),
          Text(
            "00:${time.toString().padLeft(2, '0')}",
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
            )
          ),
        ],
      );
    }

    void nextQuestion() {
      Future.delayed(
        const Duration(seconds: 1), () {
          index++;
          if(index >= questions.length || life <= 0){
            if(context.mounted){
              Navigator.pop(context);
            }
            return;
          }

          setState(() {
            answered = false;
            chosenAnswer = -1;
          });
        }
      );
    }

    void answer(int index){
      if(answered) return;

      setState(() {
        if(super.widget.typeGames == TypeGame.infinite
        && questions[this.index].correct != index){
          life--;
        }
        answered = true;
        chosenAnswer = index;
      });

      nextQuestion();
    }

    Widget answerCard(int index){
      QuestionData question = questions[this.index];
      String answerTxt = question.answers[index];

      Color bgColor = Colors.white;
      Color iconColor = Colors.grey;

      if(answered){
        if(index == question.correct){
          bgColor = Colors.green.withAlpha(100);
          iconColor = Colors.green;
        }else if(index == chosenAnswer){
          bgColor = Colors.red.withAlpha(100);
          iconColor = Colors.red;
        }
      }

      return GestureDetector(
        onTap: () => answer(index),
        child: RoundCard(
          color: bgColor,
          padding: const EdgeInsets.fromLTRB(20,15,20,15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.circle,
                color: iconColor,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  answerTxt,
                  style: textTheme.titleSmall?.copyWith(
                    fontSize: 16
                  )
                )
              )
            ],
          )
        ),
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
      if(index >= questions.length){
        Navigator.pop(context);
        return Column();
      }

      QuestionData question = questions[index];
      List<Widget> answers = [];
      for(int i = 0; i < question.answers.length; i++){
        answers.add(answerCard(i));
      }
      Widget? header;
      switch(super.widget.typeGames){
        case TypeGame.infinite:
          header = lifeRemain();
          break;
        case TypeGame.run:
          header = timeRemain();
          break;
        default:
          header = null;
          break;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          if(header != null) header,
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
                  question.question,
                  style: textTheme.bodyMedium
                ),
                if(question.img.isNotEmpty)
                const SizedBox(height: 30),
                if(question.img.isNotEmpty)
                Image.network(question.img)
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
              questions.shuffle();
              index = 0;
              return body();
            },
          )
        )
      )
    );
  }
}