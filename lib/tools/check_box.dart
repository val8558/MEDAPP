import 'package:flutter/material.dart';

class ListCheckbox extends StatefulWidget {
  final ValueChanged<int> index;
  final int initialIndex;
  final List<CheckBoxInfo> checkboxs;
  final double? width;

  const ListCheckbox({
    required this.index,
    this.initialIndex = 0,
    required this.checkboxs,
    this.width,
    super.key
  });

  @override
  State<ListCheckbox> createState() => _ListCheckboxState();
}

class _ListCheckboxState extends State<ListCheckbox> {
  int index = -1;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if(index < 0){
      index = super.widget.initialIndex;
    }

    for(int i = 0; i < super.widget.checkboxs.length; i++){
      CheckBoxInfo info = super.widget.checkboxs[i];

      children.add(
        Row(
          children:[
            Checkbox(
              value: i + 1 == index,
              onChanged: (value){
                if(value == true){
                  index = i + 1;
                }
                else{
                  index = 0;
                }

                setState(() {
                  super.widget.index(index);
                });
              },
              side: WidgetStateBorderSide.resolveWith(
                  (states) => BorderSide(
                    width: 1.5,
                    color: info.borderColor
                  ),
              ),
            ),
            if(info.complement != null)
            info.complement!
          ]
        )
      );
    }

    return SizedBox(
      width: super.widget.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: children
      )
    );
  }
}

class CheckBoxInfo{
  final Widget? complement;
  final Color borderColor;

  CheckBoxInfo({this.complement, this.borderColor = Colors.black});
}