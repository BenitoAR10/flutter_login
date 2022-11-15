// authentication bloc será el encargado de manejar el estado de autenticación de la aplicación
import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';


class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> { // AuthenticationBloc extiende de Bloc que recibe dos tipos de parámetros AuthenticationEvent y AuthenticationState
  AuthenticationBloc({ // AuthenticationBloc recibe como parámetro un AuthenticationRepository y un UserRepository 
      required AuthenticationRepository authenticationRepository, 
      required UserRepository userRepository, 
    })  : _authenticationRepository = authenticationRepository, 
        _userRepository = userRepository, // inicializamos los atributos
      super(const AuthenticationState.unknown()) { // el estado inicial es desconocido
        on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged); // escucha el evento AuthenticationStatusChanged
        on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested); // escucha el evento AuthenticationLogoutRequested
        _authenticationStatusSubscription = _authenticationRepository.status.listen( 
          (status) => add(AuthenticationStatusChanged(status)), // agrega el evento AuthenticationStatusChanged con el estado de autenticación que se recibe del AuthenticationRepository 
      );
    }

  final AuthenticationRepository _authenticationRepository; // declaramos un atributo privado de tipo AuthenticationRepository
  final UserRepository _userRepository; // declaramos un atributo privado de tipo UserRepository
  late StreamSubscription<AuthenticationStatus> // declaramos un atributo privado de tipo StreamSubscription que recibe un AuthenticationStatus 
      _authenticationStatusSubscription; 

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  } // cancela la suscripción al estado de autenticación del AuthenticationRepository y cierra el AuthenticationBloc 

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit, // Emitter es un callback que se ejecuta cuando se emite un estado 
  ) // escucha el evento AuthenticationStatusChanged y cambia el estado de autenticación de la aplicación
  async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated: // si el estado de autenticación es no autenticado
        return emit(const AuthenticationState.unauthenticated()); // retorna el estado no autenticado
      case AuthenticationStatus.authenticated: // si el estado de autenticación es autenticado
        final user = await _tryGetUser(); // intenta obtener el usuario del UserRepository 
        return emit(
          user != null 
              ? AuthenticationState.authenticated(user) // si el usuario no es nulo retorna el estado autenticado con el usuario
              : const AuthenticationState.unauthenticated(), // si el usuario es nulo retorna el estado no autenticado
        ); 
      case AuthenticationStatus.unknown: // si el estado de autenticación es desconocido
        return emit(const AuthenticationState.unknown()); // retorna el estado desconocido
    }
  } 

  void _onAuthenticationLogoutRequested( // escucha el evento AuthenticationLogoutRequested y cierra la sesión del usuario
    AuthenticationLogoutRequested event, 
    Emitter<AuthenticationState> emit, // cambia el estado de autenticación de la aplicación 
  ) {
    _authenticationRepository.logOut(); // cierra la sesión del usuario 
  }

  Future<User?> _tryGetUser() async { // intenta obtener el usuario del UserRepository 
    try { 
      final user = await _userRepository.getUser(); // obtiene el usuario del UserRepository  
      return user; 
    } catch (_) {
      return null; // si no se puede obtener el usuario retorna nulo
    }
  }
}
