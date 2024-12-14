import 'package:flutter/material.dart';

abstract class Popup extends StatelessWidget{
  
  const Popup({super.key});

  static void load(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

  static void alert({
    required BuildContext context,
    required String alert,
    String title = "",
    bool barrierDismissible = false,
    List<AlertButton>? buttons
  }){
    if(!context.mounted) return;
    TextTheme textTheme = Theme.of(context).textTheme;
    
    List<TextButton>? actions;
    if(buttons != null){
      actions = [];
      for(AlertButton button in buttons){
        actions.add(TextButton(
          onPressed: ()=>button.onPressed.call(),
          child: Text(button.text)
          )
        );
      }
    }
    
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context){
        return AlertDialog(
          title: title.isEmpty
          ? null
          : Text(title, style: textTheme.titleSmall),
          content: Text(alert, style: textTheme.bodySmall),
          actions: actions,
        );
      }
    );
  }
}

class AlertButton{
  String text;
  Function onPressed;

  AlertButton({required this.text, required this.onPressed});
}