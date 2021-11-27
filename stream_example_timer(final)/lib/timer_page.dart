import 'dart:async';

import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  bool isTimerActive = false;
  final controller = StreamController<int>();
  late StreamSubscription subscription;
  int currentValue = 0;

  @override
  void initState() {
    super.initState();
    subscription = controller.stream.listen((nextValue) {
      currentValue = nextValue;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentValue.toString(),
              style: const TextStyle(fontSize: 24),
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
    isTimerActive = !isTimerActive;
    print('start/stop pressed.\ntimer is set as $isTimerActive');

    while (true) {
      await Future.delayed(const Duration(seconds: 1));

      if (!isTimerActive) {
        break;
      }

      controller.add(currentValue + 1);
    }
  }
}
