import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:medapp/models/user_data.dart';
import 'package:medapp/server_manager.dart';
import 'package:medapp/tools/all_text.dart';
import 'package:medapp/tools/input_box.dart';
import 'package:medapp/tools/popup.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    double contentHeight = 600;

    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    void errorOnLogin(){
      if(context.mounted){
        Navigator.pop(context);
      }

      Popup.alert(
        context: context,
        alert: "O login não completado, verique seu email e senha",
        title: "Erro",
        buttons: [
          AlertButton(
            text: "Ok",
            onPressed: ()=>Navigator.pop(context)
          )
        ]
      );
    }

    Future<bool> login() async{
      if(email.text.isEmpty || password.text.isEmpty){
        return false;
      }
      Popup.load(context);
      try{
        bool sucess = await ServerManager.login(
          email: email.text,
          password: password.text
        );
        if(sucess){
          UserData? userData = await ServerManager.getUserData();
          if(context.mounted){
            Navigator.pushReplacementNamed(context, '/home');
          }
          return userData != null;
        }else{
          errorOnLogin();
        }
        
        return false;
      }
      on FirebaseAuthException {
        errorOnLogin();
        return false;
      }
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight;

        return SingleChildScrollView(
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
                            controller: email
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
                            onPressed: ()=> login(),
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
        );
      },
    );
  }
}