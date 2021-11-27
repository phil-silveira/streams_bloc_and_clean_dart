import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  bool isColorGeneratorActive = false;
  StreamSubscription? subscription;
  MaterialColor currentColor = Colors.blue;

  final List<MaterialColor> colors = [
    Colors.amber,
    Colors.red,
    Colors.pink,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.brown,
    Colors.cyan,
    Colors.indigo,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: currentColor,
        title: const Text('Color Party'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: currentColor,
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onStartStopPressed,
              child: const Text('Start/Stop'),
            )
          ],
        ),
      ),
    );
  }

  _onStartStopPressed() async {
    isColorGeneratorActive = !isColorGeneratorActive;
    print(
        'start/stop pressed.\n colors generator is set as $isColorGeneratorActive');

    if (isColorGeneratorActive) {
      subscription = generateRandomColor().listen((nextColor) {
        currentColor = nextColor;
        setState(() {});
      });
    } else {
      subscription?.cancel();
    }
  }

  Stream<MaterialColor> generateRandomColor() async* {
    int index = 0;

    while (true) {
      await Future.delayed(const Duration(seconds: 1));

      if (!isColorGeneratorActive) break;

      index = Random().nextInt(colors.length);
      yield colors[index];
    }
  }
}
