import 'package:flutter/material.dart';
import 'package:medapp/models/question_data.dart';
import 'package:medapp/models/question_theme_data.dart';
import 'package:medapp/server_manager.dart';
import 'package:medapp/tools/round_card.dart';

class QuizBody extends StatefulWidget {
  final TypeGame typeGame;
  final String theme;
  final int maxAlternative;
  final ValueNotifier<int>? life;
  const QuizBody({
    required this.typeGame,
    required this.theme,
    required this.maxAlternative,
    this.life,
    super.key
  });

  @override
  State<QuizBody> createState() => QuizBodyState();
}

class QuizBodyState extends State<QuizBody> {
  List<QuestionData> questions = [];
  int index = -1;
  bool answered = false;
  int chosenAnswer = -1;
  int correctAnswers = 0;
  ValueNotifier<int>? life;

  void nextQuestion() {
      if (index < questions.length - 1) {
        setState(() {
          index++;
          answered = false;
          chosenAnswer = -1;
        });
      }
    }

    void previousQuestion() {
      if (index > 0) {
        setState(() {
          index--;
          answered = false;
          chosenAnswer = -1;
        });
      }
    }

  @override
  void dispose() {
    if(life != null) life!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // ignore: unused_local_variable
    TextTheme textTheme = Theme.of(context).textTheme;
    life = super.widget.life;

    void nextQuestion() {
      Future.delayed(
        const Duration(seconds: 1), () {
          index++;
          if(index >= questions.length){
            if(context.mounted){
              Navigator.pushReplacementNamed(
                context,
                '/score', 
                arguments: {
                  'questions': questions.length,
                  'answers': correctAnswers,
                }
              );
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

    void answer(int index) {
      if (answered) return;

      setState(() {
        if(questions[this.index].correct == index){
          correctAnswers++;
        }else{
          if (life != null) life!.value--;
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

    Widget body(){
      if(questions.isEmpty){
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.question_mark, size: 100),
              const SizedBox(height: 20),
              Text(
                "Nenhuma questão encontrada",
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 20
                )
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Voltar")
              )
            ],
          )
        );
      }
      if(index >= questions.length){
        Navigator.pop(context);
        return Column();
      }

      QuestionData question = questions[index];
      List<Widget> answers = [];
      List<int> order = question.data['answers_order'];
      for(int i = 0; i < order.length; i++){
        answers.add(answerCard(order[i]));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        ],
      );
    }

    return questions.isNotEmpty
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

        for(QuestionData question in questions){
          List<int> answers = List.generate(question.answers.length - 1, (i) => i);
          answers.shuffle();
          answers.remove(question.correct);
          List<int> indexes = [question.correct];
          for(int index in answers){
            if(indexes.length >= super.widget.maxAlternative){
              break;
            }
            indexes.add(index);
          }

          indexes.shuffle();
          question.data["answers_order"] = indexes;
        }

        index = 0;
        return body();
      },
    );
  }
}