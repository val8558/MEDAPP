import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:medapp/server_manager.dart';

class Score extends StatelessWidget {
  final int questions;
  final int correctAnswers;
  final Map<String, dynamic> data;
  const Score({
    required this.questions,
    required this.correctAnswers,
    this.data = const {},
    super.key
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // ignore: unused_local_variable
    TextTheme textTheme = Theme.of(context).textTheme;

    Widget body () {
      return Stack(
          children: [
            ClipPath(
              clipper: ArcClipper(),
              child: Container(
                height: 200,
                color: colorScheme.primary,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 200),
                Text(
                  "Sua Pontuação",
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: 40
                  )
                ),
                Text(
                  "$correctAnswers/$questions",
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 70
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: ()=> Navigator.pushReplacementNamed(
                        context,
                        '/home', 
                      ),
                      child: Text("Voltar ao menu")
                    )
                  )
                )
              ]
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: WaveClipperTwo(reverse: true),
                child: Container(
                  height: 200,
                  color: colorScheme.primary
                ),
              ),
            )
          ]
        );
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: data.isEmpty
        ? body()
        : FutureBuilder(
          future: ServerManager.setUsage(data),
          builder: (context, snapshot){
            data.clear();
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            
            return body();
          }
        ),
      )
    );
  }
}