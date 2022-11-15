part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}
// creamos un evento que nos permite saber si el nombre de usuario cambió
class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged (this.username);

  final String username;

  @override
  List<Object> get props => [username];
} 
// creamos un evento que nos permite saber si la contraseña cambió
class LoginPasswordChanged extends LoginEvent{
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}
// creanoos un evento que nos permite saber si el usuario presionó el botón de iniciar sesión
class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
