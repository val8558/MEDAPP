import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:medmaster/tools/all_text.dart';
import 'package:medmaster/tools/input_box.dart';

class Login extends StatelessWidget {
  final double width, height;
  const Login({required this.width, required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    double contentHeight = 600;

    TextEditingController user = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height > contentHeight? height: contentHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                flex: 2,
                child: SizedBox(
                  height: 100
                )
              ),
              SizedBox(
                height: contentHeight,
                child: Column(
                  children: [
                    Image.asset('assets/logo.png', height: 100),
                    Text(
                      LoginText.title.toUpperCase(),
                      style: textTheme.titleMedium
                      ?.copyWith(
                        color: colorScheme.primary
                      ),
                    ),
                    InputBox(
                      inputs: [
                        InputFieldInfo(
                          title: LoginText.user,
                          controller: user
                        ),
                        InputFieldInfo(
                          password: true,
                          title: LoginText.password,
                          controller: password
                        ),
                      ],
                      buttons: [
                        TextButtonInfo(
                          text: LoginText.button,
                          onPressed: ()=> Navigator.pushReplacementNamed(context, '/home')
                        )
                      ],
                      afterButtons: Column(
                        children: [
                          InkWell(
                            child: Text(
                              LoginText.forget,
                              style: textTheme.bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold
                              )
                            ),
                            onTap: ()=> print("AAAAAAAAAAAAA")
                          ),
                          Text("|", style: textTheme.bodySmall),
                          InkWell(
                            child: Text(
                              LoginText.singIn,
                              style: textTheme.bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold
                              )
                            ),
                            onTap: ()=> Navigator.pushNamed(context, '/sing_in')
                          )
                        ],
                      )
                    ),
                  ],
                )
              ),
              Flexible(
                flex: 3,
                child: ClipPath(
                  clipper: WaveClipperTwo(reverse: true),
                  child: Container(
                    color: colorScheme.primary
                  ),
                ),
              )
            ],
          ),
        )
      )
    );
  }
}