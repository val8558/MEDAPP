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

    String getNameButton(TypeGame game){
      switch(game){
          case TypeGame.run:
            return "Corrida";
          case TypeGame.infinite:
            return "Infinito";
          case TypeGame.flash:
            return "Flashcard";
          default:
           return "Jogar";
      }
    }

    RoundCard card(QuestionThemeData question){
      List<TextButton> buttons = [];

      for(TypeGame game in question.games){
        String name = getNameButton(game);

        if(question.games.length == 1){
          name = "Jogar";
        }
        
        var arguments = { 'type': game,'theme': question.id };
        if(game == TypeGame.flash) arguments['max'] = 2;
        
        buttons.add(
          TextButton(
            onPressed: () => Navigator.pushNamed(
              context,
              '/quiz', 
              arguments: arguments
            ),
            child: Text(name)
          )
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