import 'package:flutter/material.dart';
import 'package:medmaster/tools/all_text.dart';

class Home extends StatelessWidget {
  final double width, height;
  const Home({required this.width, required this.height, super.key});

  Container card({
    EdgeInsets margin = const EdgeInsets.all(10),
    EdgeInsets padding = const EdgeInsets.all(15),
    BorderRadius border = const BorderRadius.all(
      Radius.circular(30)
    ),
    required Widget child,
  }){
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: border
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              card(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 15),
                border: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)
                ),
                child: Row(
                  children: [
                    const Icon(Icons.person_2_sharp, size: 40),
                    Text(HomeText.hello, style: textTheme.titleMedium)
                  ],
                ),
              ),
              card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: HomeText.quiz,
                              style: textTheme.titleSmall?.copyWith(
                                fontSize: 18
                              ),
                              children: [
                                TextSpan(
                                  text: "\n${HomeText.subQuiz}",
                                  style: textTheme.labelMedium
                                ),
                              ]
                            ),
                          ),                       
                          TextButton(
                            onPressed: null,
                            child: Text(HomeText.buttonQuiz)
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/fixed_quiz.png',
                      height: 120,
                      alignment: Alignment.centerRight,
                    ),
                  ],
                )
              )
            ],
          ),
        )
      )
    );
  }
}