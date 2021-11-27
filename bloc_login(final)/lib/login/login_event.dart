abstract class LoginEvent {}

class DoLoginEvent extends LoginEvent {
  final String email;
  final String password;

  DoLoginEvent({
    required this.email,
    required this.password,
  });
}
