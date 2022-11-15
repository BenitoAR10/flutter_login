import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_login/login/login.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

// El LoginBloc es responsable de reaccionar a las interacciones del usuario en el formulario de inicio de sesióny de gestionar la validacion y envio de los datos de inicio de sesión.


// creamos la clase LoginBloc que extiende de Bloc y recibe como parametro un LoginEvent y un LoginState.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) { // inicializamos el estado del LoginBloc con el estado LoginState.
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  } // instancioamos el AuthenticationRepository que se pasa como parametro al constructor de la clase LoginBloc.

  final AuthenticationRepository _authenticationRepository;

  // creamos la funcion para cuando el usuario cambia el username. 
  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    //Creamos una instancia de Username y le pasamos el username que se recibe como parametro. Luego emitimos un nuevo estado con el estado actual y el nuevo username.
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([state.password, username]),
      ),
    );
  } 

  // creamos la funcion para cuando el usuario cambia el password.

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    // Creamos una instancia de Password y le pasamos el password que se recibe como parametro. Luego emitimos un nuevo estado con el estado actual y el nuevo password.
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([password, state.username]),
      ),
    );
  }

  // creamos la funcion para cuando el usuario envia el formulario de inicio de sesion. 

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async { 
    if (state.status.isValidated) { // si el estado es valido entonces emitimos un estado de carga.
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        ); // autehticamos al usuario con el username y el password. Si es exitoso emitimos un estado de exito.
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) { // si no es exitoso emitimos un estado de error.
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
