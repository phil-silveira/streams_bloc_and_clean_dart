import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LoginEvent {}

class DoLoginEvent extends LoginEvent {
  final String email;
  final String password;

  DoLoginEvent(this.email, this.password);
}

abstract class LoginState {}

class LoginIdleState extends LoginState {}

class LoadingState extends LoginState {
  final bool isLoading;

  LoadingState(this.isLoading);
}

class LoginSuccessState extends LoginState {}

class LoginFailState extends LoginState {}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginIdleState()) {
    on<DoLoginEvent>((event, emit) async {
      emit(LoadingState(true));

      await Future.delayed(const Duration(seconds: 2));

      emit(LoginSuccessState());

      emit(LoadingState(false));
    });
  }
}
