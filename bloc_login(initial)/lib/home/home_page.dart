import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const route = 'home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amber,
    );
  }
}
