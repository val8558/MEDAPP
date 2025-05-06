import 'package:flutter/material.dart';
import 'package:medapp/tools/round_card.dart';

abstract class DefaultTheme extends StatelessWidget {
  const DefaultTheme({super.key});
  final String defaultTxt = "Bem vindo ao Quiz fixo. Nesta modalidade de jogo você escolherá o tema das questões"
  " e a dificuldade delas.\n\nEscolha entre os modos infinito ou corrida contra o tempo.";

  Widget baseBody({
    required BuildContext context,
    required String title,
    required String subTitle,
    Image? image,
    Widget? body
  }){
    // ignore: unused_local_variable
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // ignore: unused_local_variable
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if(image != null) image,
              RoundCard(
                color: colorScheme.primary,
                padding: const EdgeInsets.fromLTRB(15,20,15,20),
                child: RichText(
                  text: TextSpan(
                    text: "$title\n",
                    style: textTheme.titleSmall?.copyWith(
                      fontSize: 18
                    ),
                    children: [
                      TextSpan(
                        text: subTitle,
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ]
                  ),
                ), 
              ),
              if(body != null) body
            ],
          ),
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return baseBody(
      context: context,
      title: '',
      subTitle: defaultTxt
    );
  }
}