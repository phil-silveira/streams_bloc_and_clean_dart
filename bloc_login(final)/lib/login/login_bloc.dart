import 'package:bloc/bloc.dart';
import 'package:register/login/login_event.dart';
import 'package:register/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<DoLoginEvent>((event, emit) async {
      print('Bloc: recebi um evento do tipo DoLogin');

      emit(LoadingState());

      await Future.delayed(const Duration(seconds: 2));
      if (event.email == 'jorel@gmail.com' && event.password == '1234') {
        emit(LoginSuccessState());
      } else {
        emit(LoginFailState());
      }
    });
  }
}
