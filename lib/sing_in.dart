import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:medapp/server_manager.dart';
import 'package:medapp/tools/all_text.dart';
import 'package:medapp/tools/input_box.dart';
import 'package:medapp/tools/popup.dart';

class SingIn extends StatelessWidget {
  const SingIn({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextEditingController name, user, email, confirmEmail, password, confirmPass, ie;
 
    name = TextEditingController();
    user = TextEditingController();
    email = TextEditingController();
    confirmEmail = TextEditingController();
    password = TextEditingController();
    confirmPass = TextEditingController();
    ie = TextEditingController();

    bool checkParameters(List<String> parameters){
      for(String param in parameters){
        if(param.isEmpty){
          return false;
        }
      }

      return true;
    }

    singIn(){
      List<String> params = [name.text, email.text, password.text, user.text, ie.text];

      if(!checkParameters(params)){
        Popup.alert(
          context: context,
          title: "Atenção",
          alert: "Preencher campos obrigatórios",
          buttons: [
            AlertButton(
              text: "ok", 
              onPressed: ()=> Navigator.pop(context)
            )
          ]
        );
        return;
      }

      if(email.text != confirmEmail.text){
        Popup.alert(
          context: context,
          title: "Atenção",
          alert: "Verifique se o campo email e repita seu email, os dois campos devem ser iguais, os dois campos devem ser iguais",
          buttons: [
            AlertButton(
              text: "ok", 
              onPressed: ()=> Navigator.pop(context)
            )
          ]
        );
        return;
      }

      if(password.text != confirmPass.text){
        Popup.alert(
          context: context,
          title: "Atenção",
          alert: "Verifique se o campo senha e repita sua senha, os dois campos devem ser iguais",
          buttons: [
            AlertButton(
              text: "ok", 
              onPressed: ()=> Navigator.pop(context)
            )
          ]
        );
        return;
      }

      /*if(terms == 0){
        Popup.alert(
          context: context,
          title: "Atenção",
          alert: "Verifique o acordo de licença e o termos de privacidade,\n"
            "aceite-os para progresseguir",
          buttons: [
            AlertButton(
              text: "ok", 
              onPressed: ()=> Navigator.pop(context)
            )
          ]
        );
        return;
      }*/

      Popup.load(context);

      ServerManager.createUser(
        context: context,
        name: name.text,
        user: user.text,
        email: email.text,
        password: password.text,
        ie: ie.text
      ).then((result){
        if(!context.mounted) return null;
        if(result != null){
          Navigator.pushReplacementNamed(context, '/home');	
        }else{
          Navigator.pop(context);
          Popup.alert(
            context: context,
            title: "Erro",
            alert: "Algo deu errado, tente novamente",
            buttons: [
              AlertButton(
                text: "ok", 
                onPressed: ()=> Navigator.pop(context)
              )
            ]
          );
        }
      });
    }

    return SingleChildScrollView(
      child: Stack(
        children: [
          ClipPath(
            clipper: ArcClipper(),
            child: Container(
              height: 130,
              color: colorScheme.primary,
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
                    controller: name,
                  ),
                  InputFieldInfo(
                    title: SingInText.user,
                    controller: user,
                  ),
                  InputFieldInfo(
                    title: SingInText.email,
                    controller: email,
                  ),
                  InputFieldInfo(
                    title: SingInText.repeatEmail,
                    controller: confirmEmail,
                  ),
                  InputFieldInfo(
                    password: true,
                    title: SingInText.password,
                    controller: password,
                  ),
                  InputFieldInfo(
                    password: true,
                    title: SingInText.repeatPass,
                    controller: confirmPass,
                  ),
                  InputFieldInfo(
                    title: SingInText.ie,
                    controller: ie,
                  ),
                ],
                buttons: [
                  TextButtonInfo(
                    text: SingInText.button,
                    onPressed: () => singIn(),
                  ),
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ]
      ),
    );
  }
}