import 'package:flutter/material.dart';
import 'package:medapp/models/user_data.dart';
import 'package:medapp/server_manager.dart';
import 'package:medapp/tools/all_text.dart';
import 'package:medapp/tools/round_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static Map<int, List<int>> usage = {};

  List<String> getCurrentWeekDays() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final daysOfWeek = List.generate(7, (index) {
      final day = startOfWeek.add(Duration(days: index));
      return day.day.toString().padLeft(2, '0');
    });
    return daysOfWeek;
  }

  String getCurrentDay() {
    final now = DateTime.now();
    List<String> months = ["Janeiro", "fevereiro", "março", "abril", "maio", "junho", "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"];

    final day = now.day.toString().padLeft(2, '0');
    return "$day, ${months[now.month - 1]} de ${now.year}";
  }

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

    RoundCard dates() {
      List<int> daysUsed = usage[DateTime.now().month] ?? [];

      List<Container> dayCards = [];
      List<String> days = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab', 'Dom'];
      List<String> weekDays = getCurrentWeekDays();
      for(int i = 0; i < weekDays.length; i++){
        bool active = daysUsed.contains(int.parse(weekDays[i]));
        dayCards.add(dayCard(days[i], weekDays[i], active: active));
      }

      return RoundCard(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 15),
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        border: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getCurrentDay(), style: textTheme.titleSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: dayCards
            )
          ]
        )
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
              usage.isNotEmpty
              ? dates()
              : FutureBuilder(
                  future: ServerManager.getUsage(DateTime.now().year.toString()),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.hasData) usage = snapshot.data!;
                    return dates();
                  }
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
                onPressed: () => Navigator.pushNamed(context, '/random_chose_theme')
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
                onPressed: () => Navigator.pushNamed(context, '/flash_chose_theme')
              ),
            ],
          ),
        )
      )
    );
  }
}