part of 'login_bloc.dart';
// Login state contendra los estados del formulario de inicio de sesión asi como los estados de entrada de usuario y contraseña
class LoginState extends Equatable {

  
  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });
  // creamos una función que nos permite copiar los estados del formulario de inicio de sesión
  final FormzStatus status;
  final Username username;
  final Password password;

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  } 

  @override
  List<Object> get props => [status, username, password];
}
