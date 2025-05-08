import 'dart:async';

import 'package:flutter/material.dart';

class TimeRemain extends StatefulWidget {
  
  const TimeRemain({super.key});

  @override
  State<TimeRemain> createState() => _TimeRemainState();
}

class _TimeRemainState extends State<TimeRemain> {
  int time = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (time > 0) {
        setState(() {
          time--;
        });
      } else {
        t.cancel();
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // ignore: unused_local_variable
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 10,
              thumbColor: Colors.transparent,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0)
            ),
            child: Slider(
              value: time.toDouble(),
              max: 60,
              min: 0,
              activeColor: colorScheme.primary,
              inactiveColor: Colors.white,
              onChanged: (double value) {},
            ),
          ),
          Text(
            "00:${time.toString().padLeft(2, '0')}",
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
            )
          ),
        ],
      );
  }
}