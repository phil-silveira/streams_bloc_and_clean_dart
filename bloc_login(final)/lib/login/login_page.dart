import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register/login/login_bloc.dart';
import 'package:register/login/login_event.dart';

import 'login_state.dart';
import 'security_code_page.dart';

class LoginPage extends StatefulWidget {
  static const route = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final passwordNode = FocusNode();

  String? email;
  String? password;

  late LoginBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        print('recebi um novo state');

        if (state is LoginSuccessState) {
          Navigator.of(context).pushNamed(SecurityCodePage.route);
        }

        if (state is LoginFailState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Credenciais inválidas'),
            ),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                  ),
                  onSaved: (text) {
                    email = text;
                  },
                  validator: (text) => text?.contains('@') ?? false
                      ? null
                      : 'Preencha o e-mail corretamente',
                  onFieldSubmitted: (_) {
                    passwordNode.requestFocus();
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  focusNode: passwordNode,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  onSaved: (text) {
                    password = text;
                  },
                  validator: (text) => (text?.length ?? 0) < 3
                      ? 'Preencha a senha corretamente'
                      : null,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text(
                        'Don\'t have an account?',
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 52),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    child: BlocBuilder(
                        bloc: bloc,
                        builder: (context, state) {
                          if (state is LoadingState) {
                            return const CircularProgressIndicator(
                              color: Colors.white,
                            );
                          }

                          return const Text(
                            'Continue',
                          );
                        }),
                    onPressed: onContinuePressed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onContinuePressed() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      bloc.add(
        DoLoginEvent(
          email: email!,
          password: password!,
        ),
      );
    }
  }
}
