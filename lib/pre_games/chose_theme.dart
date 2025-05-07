import 'package:flutter/material.dart';
import 'package:medapp/models/question_theme_data.dart';
import 'package:medapp/pre_games/default_theme.dart';
import 'package:medapp/server_manager.dart';
import 'package:medapp/tools/round_card.dart';

class ChoseTheme extends DefaultTheme {
  final String title;
  final String type;
  final Image image;

  const ChoseTheme({
    required this.title,
    required this.type,
    required this.image,
    super.key
  });

  @override
  Widget build(BuildContext context){
    // ignore: unused_local_variable
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // ignore: unused_local_variable
    TextTheme textTheme = Theme.of(context).textTheme;

    RoundCard card(QuestionThemeData question){
      List<TextButton> buttons = [];

      if(question.games.contains(TypeGames.run)){
        buttons.add(
          TextButton(
            onPressed: () => Navigator.pushNamed(
              context, 
              '/quiz', 
              arguments: {
                'type': TypeGames.run,
                'theme': question.id,
              }
            ),
            child: Text("Corrida")
          )
        );
      }

      if(question.games.contains(TypeGames.infinite)){
        buttons.add(
          TextButton(
            onPressed: () => Navigator.pushNamed(
              context, '/quiz',
              arguments: {
                'type': TypeGames.run,
                'theme': question.id,
              }
            ),
            child: Text("Infinito")
          ),
        );
      }

      if(buttons.length == 1){
        var onPressed = buttons[0].onPressed;
        buttons[0] = TextButton(
          onPressed: onPressed,
          child: Text("Jogar")
        );
      }

      return RoundCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            image,
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: question.title,
                      style: textTheme.titleSmall?.copyWith(
                        fontSize: 18
                      ),
                      children: [
                        if(question.subTitle.isNotEmpty)
                        TextSpan(
                          text: "\n${question.subTitle}",
                          style: textTheme.labelMedium
                        ),
                      ]
                    ),
                  ),
                  const SizedBox(height: 15),
                  Column(children: buttons)
                ],
              ),
            ),
          ],
        )
      );
    }

    return super.baseBody(
      context: context,
      title: title,
      subTitle: defaultTxt,
      image: image,
      body: FutureBuilder(
        future: ServerManager.getThemes(type),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }

          List<QuestionThemeData> themes = snapshot.data!;
          List<Widget> cards = [];
          for (var element in themes) {
            cards.add(
              card(element)
            );
          }

          return Column(children: cards);
        },
      )
    );
  }
}