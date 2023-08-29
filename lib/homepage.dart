import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isPressed = false;
  int mode = 1;
  Color backgroundColor = Colors.red;

  Color getRandomColor() {
    Random random = Random();
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    return Color.fromARGB(255, r, g, b);
  }

  Timer? colorChangeTimer;

  void changeBackground(bool toStart) {
    if (toStart) {
      colorChangeTimer =
          Timer.periodic(Duration(seconds: (1 / mode).round()), (timer) {
        setState(() {
          backgroundColor = getRandomColor();
        });
      });
    } else {
      colorChangeTimer?.cancel();
      setState(() {
        backgroundColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isPressed = !isPressed;
                    changeBackground(isPressed);
                  });
                },
                child: Row(
                  children: [
                    !isPressed
                        ? const Icon(Icons.play_arrow)
                        : const Icon(Icons.pause),
                    !isPressed ? const Text("Start") : const Text("Stop"),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: !isPressed
                    ? () {
                        setState(() {
                          if (mode == 5) {
                            mode = 0;
                          }
                          mode++;
                        });
                      }
                    : null,
                child: Row(
                  children: [
                    const Icon(Icons.settings),
                    Text("Mode: $mode"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
