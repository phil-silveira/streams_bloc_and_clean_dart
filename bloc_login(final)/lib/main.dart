import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register/login/login_page.dart';
import 'package:register/login/security_code_page.dart';

import 'home/home_page.dart';
import 'login/login_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primarySwatch: Colors.red,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Color(0xFF4A4A4A)),
            ),
            textTheme: const TextTheme(
              headline4: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontSize: 34,
              ),
              bodyText1: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              floatingLabelStyle: TextStyle(
                color: Color(0xFF9B9B9B),
              ),
              labelStyle: TextStyle(
                color: Color(0xFFB5B5B5),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                  ),
                ),
              ),
            )),
        initialRoute: LoginPage.route,
        routes: {
          LoginPage.route: (_) => const LoginPage(),
          SecurityCodePage.route: (_) => const SecurityCodePage(),
          HomePage.route: (_) => const HomePage(),
        },
      ),
    );
  }
}
