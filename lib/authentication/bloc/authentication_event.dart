// primero importamos el archivo authentication_bloc.dart
// Las instancias de AuthenticationEvent son enviadas al AuthenticationBloc
part of 'authentication_bloc.dart'; 

// creamos una clase abstracta AuthenticationEvent que extiende de Equatable para poder comparar eventos
abstract class AuthenticationEvent extends Equatable{
  const AuthenticationEvent(); 

  @override
  List<Object> get props => []; // retorna una lista de objetos
}

// creamos una clase AuthenticationStatusChanged que extiende de AuthenticationEvent para poder cambiar el estado de autenticación
class AuthenticationStatusChanged extends AuthenticationEvent{ 

  final AuthenticationStatus status; 

  const AuthenticationStatusChanged(this.status);

  @override
  List<Object> get props => [status];
}

class AuthenticationLogoutRequested extends AuthenticationEvent{}