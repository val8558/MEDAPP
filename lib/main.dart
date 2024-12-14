import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medmaster/firebase_options.dart';
import 'package:medmaster/login.dart';
import 'package:medmaster/tools/default_scaffold.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

/*
ColorScheme colorScheme = Theme.of(context).colorScheme;
TextTheme textTheme = Theme.of(context).textTheme;
*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color onColor = Colors.black,
          primary = const Color(0xFF0BCEB2),
          secondary = const Color(0xFF003366),
          error = const Color(0xFFFF3A2F);


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,

          primary: primary,
          onPrimary: onColor,

          secondary: secondary,
          onSecondary: onColor,

          error: error,
          onError: onColor,

          surface: Colors.white,
          onSurface: onColor
        ),
        
        //TEXT
        textTheme: TextTheme(
          //Body
          bodyLarge: GoogleFonts.exo(
            fontWeight: FontWeight.normal,
            fontSize: 22,
            color: Colors.black
          ),
          bodyMedium: GoogleFonts.exo(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: Colors.black
          ),
          bodySmall: GoogleFonts.exo(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: Colors.black
          ),
          
          //Title
          titleLarge: GoogleFonts.exo(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Colors.black,
          ),
          titleMedium: GoogleFonts.exo(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
            /*letterSpacing: -1,
            height: 1.1*/
          ),
          titleSmall: GoogleFonts.exo(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            minimumSize: const WidgetStatePropertyAll(Size(175, 20)),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.fromLTRB(30, 10, 30, 10),
            ),
            backgroundColor: WidgetStatePropertyAll(primary),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            textStyle: WidgetStatePropertyAll(
              GoogleFonts.exo(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )
            )
          ),
        ),

        /*textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.grey,
          selectionColor: secondary,
          selectionHandleColor: surfaceContainer
        ),*/
        useMaterial3: true,
      ),
      home: DefaultScaffold(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){
            double width = constraints.maxWidth;
            // ignore: unused_local_variable
            double height = constraints.maxHeight;

            return Login(width: width, height: height);
          }
        )
      )
    );
  }
}