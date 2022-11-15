import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/authentication/authentication.dart';
import 'package:flutter_login/home/home.dart';
import 'package:flutter_login/splash/splash.dart';
import 'package:user_repository/user_repository.dart';
import 'login/view/login_page.dart';


class App extends StatelessWidget { 

  
  const App({ 
    super.key,
    required this.authenticationRepository, 
    required this.userRepository, 
  }); // creamos un constructor para que nos pida los repositorios de autenticación y usuario 

  final AuthenticationRepository authenticationRepository; // creamos una variable para el repositorio de autenticación
  final UserRepository userRepository; // creamos una variable para el repositorio de usuario


  @override
  // creamos un widget que nos permita usar los repositorios de autenticación y usuario en toda la aplicación 
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ), 
        child: const AppView(),
      ),
    );
    
  } 
}
// creamos un stateful widget para que nos permita cambiar de estado en la aplicación
class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
} 

class _AppViewState extends State<AppView> {

  final _navigatorKey = GlobalKey<NavigatorState>(); // inicializamos el navigator key
  // global key es una llave que nos permite acceder a un widget de manera global

  // creamos un getter que nos ayuda a acceder al estado del navigator
  NavigatorState get _navigator => _navigatorKey.currentState!; 

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      navigatorKey: _navigatorKey, // le pasamos el navigator key
      builder: (context, child) {
        // usamos un bloc listener para que nos permita escuchar los cambios de estado en la aplicación
        return BlocListener<AuthenticationBloc, AuthenticationState>( 
          listener: (context, state){ 
            switch(state.status){
              case AuthenticationStatus.authenticated:
              _navigator.pushAndRemoveUntil<void>( 
                HomePage.route(),
                (route) => false,
              );
                break;
              case AuthenticationStatus.unauthenticated:
              _navigator.pushAndRemoveUntil<void>(
                LoginPage.route(),
                (route) => false,
              );
                break;
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(), // creamos una ruta para la página de inicio splashpage 
    );
    
  }
}