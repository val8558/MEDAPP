import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputBox extends StatefulWidget {
  final String? title;
  final Widget? afterButtons;
  final List<InputFieldInfo>? inputs;
  final List<TextButtonInfo>? buttons;

  const InputBox({
    this.title,
    this.afterButtons,
    this.inputs,
    this.buttons,
    super.key
  });

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    TextField textField(InputFieldInfo input){
      return TextField(
        controller: input.controller,
        keyboardType: input.keyboardType,
        inputFormatters: input.inputFormatters,
        obscureText: input.password && !input.seeObscure,
        style: textTheme.bodyMedium,
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(12,8,12,8),
          fillColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.0
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(30)
            )
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: colorScheme.primary,
              width: 1.0
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(30)
            )
          ),
          labelStyle: textTheme.bodyMedium,
          suffixIcon: input.password
          ? IconButton(
            visualDensity: VisualDensity.compact,
            color: input.seeObscure
            ? colorScheme.primary
            : Colors.grey,
            onPressed: ()=> setState(() {
              input.seeObscure = !input.seeObscure;
            }),
            icon: Icon(
              input.seeObscure
              ? Icons.visibility_off
              : Icons.visibility,
            )
          )
          : null,
          suffixIconConstraints: const BoxConstraints(maxHeight: 20),
        ),
      );
    }

    List<Widget> children = [];
    if(super.widget.inputs != null){
      for(InputFieldInfo input in super.widget.inputs!){
        children.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                input.title,
                style: textTheme.bodyMedium
                ?.copyWith(
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: textField(input)
              ),
            ],
          ),
        );
      }
    }

    if(super.widget.buttons != null){
      List<Widget> buttonsChildren = [];

      for(TextButtonInfo button in super.widget.buttons!){
        buttonsChildren.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 40, 5, 5),
            child: TextButton(
              onPressed: button.onPressed == null
              ? null
              : ()=> button.onPressed!.call(),
              child: Text(button.text)
            )
          )
        );
      }

      children.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: buttonsChildren
        )
      );
    }

    if(super.widget.afterButtons != null){
      children.add(super.widget.afterButtons!);
    }

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          if(super.widget.title != null)
          Text(
            super.widget.title!,
            style: textTheme.titleMedium
            ?.copyWith(
              fontWeight: FontWeight.bold,
            )
          ),
          Column(children: children)
        ],
      )
    );
  }
}

class InputFieldInfo{
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool password;
  final String title;

  InputFieldInfo({
    required this.title,
    this.keyboardType,
    this.inputFormatters,
    this.password = false,
    this.controller
  });

  bool seeObscure = false;
}

class TextButtonInfo{
  final Function? onPressed;
  final String text;

  TextButtonInfo({required this.text, this.onPressed});
}