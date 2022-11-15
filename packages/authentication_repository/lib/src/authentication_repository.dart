import 'dart:async';

// Enumeracion de estados de autenticacion
enum AuthenticationStatus { unknown, authenticated, unauthenticated }



class AuthenticationRepository {
// AthenticationRepository expone una serie Stream de AuthenticationStatus
// actualizaciones que se usaran para notificar a la aplicacion cuando un
// usuario inicia o cierra sesion

  // Inicialmente, el estado de autenticacion es desconocido
  // Creamos un StreamController para manejar los eventos de autenticacion
  final _controller = StreamController<AuthenticationStatus>();

  // Creamos un getter para el StreamController
  // Escuchamos el evento de autenticacion con un Stream
  Stream<AuthenticationStatus> get status async*{
    await Future<void>.delayed(const Duration(seconds: 1)); // indicamos que la autenticacion tarda 1 segundo
    yield AuthenticationStatus.unauthenticated; // Inicialmente, el usuario no esta autenticado
    // yield es un keyword que se usa para devolver un valor de una funcion
    yield* _controller.stream; // Añadimos el StreamController al Stream
    // yield* es un operador de propagacion que permite que un Stream emita los eventos de otro Stream
  }

  // Future sirve para indicar que el metodo es asincrono y que devolvera un valor en el futuro  
  Future<void> logIn({
    required String username,
    required String password,
  }) async{
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated), 
    );
  }
  // Metodo para cerrar sesion
  void logOut(){
    _controller.add(AuthenticationStatus.unauthenticated);
  }
  // Metodo Dispose pra que el controller se pueda cerrar cuando ya no se necesite 
  void dispose() => _controller.close();
}