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

    RoundCard card(String title){
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
                      text: title,
                      style: textTheme.titleSmall?.copyWith(
                        fontSize: 18
                      ),
                    ),
                  ),                       
                  TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context, 
                      '/quiz', 
                      arguments: {
                        'theme': title,
                        'infinite': false
                      }
                    ),
                    child: Text("Corrida")
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/quiz'),
                    child: Text("Infinito")
                  ),
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
              card(element.title)
            );
          }

          return Column(children: cards);
        },
      )
    );
  }
}