import 'package:flutter/material.dart';
import 'package:medapp/models/user_data.dart';
import 'package:medapp/server_manager.dart';
import 'package:medapp/tools/all_text.dart';
import 'package:medapp/tools/round_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    Container dayCard(String day, String number, {bool active = false}){
      Color bgColor = active ? colorScheme.secondary : Colors.white;
      Color txtColor = active ? Colors.white : colorScheme.secondary;

      return Container(
        width: 40,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(15)
          ),
          border: Border.all(
            color: colorScheme.secondary,
            width: 1
          )
        ),
        child: Column(
          children: [
            Text(
              day,
              style: textTheme.labelMedium?.copyWith(
                color: txtColor
              )
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
              ),
              child: Text(
                number,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold
                )
              )
            )
          ],
        ),
      );
    }
    RoundCard themeCard({
      required String title,
      required String subTitle,
      required Image img,
      required Function onPressed,
      bool imgOnLeft = true,
    }){
      return RoundCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if(imgOnLeft) img,
            if(imgOnLeft) const SizedBox(width: 15),
            Expanded(
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
                      children: [
                        TextSpan(
                          text: "\n$subTitle",
                          style: textTheme.labelMedium
                        ),
                      ]
                    ),
                  ),
                  const SizedBox(height: 15),                
                  TextButton(
                    onPressed: ()=> onPressed.call(),
                    child: Text(HomeText.buttonQuiz)
                  )
                ],
              ),
            ),
            if(!imgOnLeft) const SizedBox(width: 15),
            if(!imgOnLeft) img
          ],
        )
      );
    }

    Row userInfo () {
      return Row(
        children: [
          const Icon(Icons.person_2_sharp, size: 40),
          Text("${HomeText.hello}, ${UserData().name}", style: textTheme.titleMedium)
        ],
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              RoundCard(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 15),
                border: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)
                ),
                child: UserData().hasInitialized()
                ? userInfo()
                : FutureBuilder(
                  future: ServerManager.getUserData(),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }
                    return userInfo();
                  }
                ),
              ),
              RoundCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hoje, 22 Agosto 2024", style: textTheme.titleSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dayCard("Seg", "19", active: true),
                        dayCard("Ter", "20"),
                        dayCard("Qua", "21"),
                        dayCard("Qui", "22", active: true),
                        dayCard("Sex", "23"),
                        dayCard("Sab", "24"),
                        dayCard("Dom", "25"),
                      ]
                    )
                  ],
                )
              ),
              themeCard(
                title: "QUIZ FIXO",
                subTitle: "Responda as questões por tema",
                img: Image.asset(
                  'assets/fixed_quiz.png',
                  height: 120,
                  alignment: Alignment.centerRight,
                ),
                imgOnLeft: false,
                onPressed: () => Navigator.pushNamed(context, '/fixed_chose_theme')
              ),
              themeCard(
                title: "QUIZ ALEATÓRIO",
                subTitle: "Responda questões mistas",
                img: Image.asset(
                  'assets/random_quiz.png',
                  height: 120,
                  alignment: Alignment.centerRight,
                ),
                imgOnLeft: true,
                onPressed: () => Navigator.pushNamed(
                  context, 
                  '/quiz',
                  arguments: {
                  'theme': "",
                  'infinite': false
                })
              ),
              themeCard(
                title: "MODO TRILHA",
                subTitle: "Escolha uma trilha para estudar",
                img: Image.asset(
                  'assets/trail_mode.png',
                  height: 120,
                  alignment: Alignment.centerRight,
                ),
                imgOnLeft: false,
                onPressed: () => Navigator.pushNamed(context, '/trail_chose_theme')
              ),
              themeCard(
                title: "FLASHCARDS",
                subTitle: "Flashcards para você testa seu conhecimento",
                img: Image.asset(
                  'assets/Flashcards.png',
                  height: 120,
                  alignment: Alignment.centerRight,
                ),
                imgOnLeft: true,
                onPressed: () => Navigator.pushNamed(context, '/flashcard_chose_theme')
              ),
            ],
          ),
        )
      )
    );
  }
}