import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:medmaster/tools/all_text.dart';
import 'package:medmaster/tools/input_box.dart';

class SingIn extends StatelessWidget {
  final double width, height;
  const SingIn({required this.width, required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    TextEditingController name, user, email, repeatEmail, password, repeatPass, ie;
 
    name = TextEditingController();
    user = TextEditingController();
    email = TextEditingController();
    repeatEmail = TextEditingController();
    password = TextEditingController();
    repeatPass = TextEditingController();
    ie = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ClipPath(
              clipper: ArcClipper(),
              child: Container(
                height: 130,
                color: colorScheme.primary
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 80),
                const Icon(Icons.person_2_sharp, size: 100),
                InputBox(
                  padding: const EdgeInsets.all(0),
                  inputs: [
                    InputFieldInfo(
                      title: SingInText.name,
                      controller: name
                    ),
                    InputFieldInfo(
                      title: SingInText.user,
                      controller: user
                    ),
                    InputFieldInfo(
                      title: SingInText.email,
                      controller: email
                    ),
                    InputFieldInfo(
                      title: SingInText.repeatEmail,
                      controller: repeatEmail
                    ),
                    InputFieldInfo(
                      password: true,
                      title: SingInText.password,
                      controller: password
                    ),
                    InputFieldInfo(
                      password: true,
                      title: SingInText.repeatPass,
                      controller: repeatPass
                    ),
                    InputFieldInfo(
                      title: SingInText.ie,
                      controller: ie
                    ),
                  ],
                  buttons: [
                    TextButtonInfo(
                      text: SingInText.button
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}