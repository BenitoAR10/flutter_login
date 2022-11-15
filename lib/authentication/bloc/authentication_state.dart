// Las instancias de AuthenticationState seran la salida del AuthenticationBloc
// la clase AuthenticationState tendra tres constructores que representan los tres estados posibles de autenticación
part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable{

  final AuthenticationStatus status; // estado de autenticación 
  final User user; // usuario
  // creamos un constructor privado para que no se pueda instanciar la clase AuthenticationState
  const AuthenticationState._({ 
    this.status = AuthenticationStatus.unknown, // el estado de autenticación por defecto es desconocido
    this.user = User.empty, // el usuario por defecto es vacio
  });

  const AuthenticationState.unknown(): 
    this._(); // constructor para el estado desconocido

  const AuthenticationState.authenticated(User user) : 
    this._(status: AuthenticationStatus.authenticated, user : user); // constructor para el estado autenticado

  const AuthenticationState.unauthenticated() :
    this._(status: AuthenticationStatus.unauthenticated); // constructor para el estado no autenticado

 
  @override
  List<Object> get props => [status, user]; // retorna una lista de objetos que representan el estado de autenticación y el usuario

}