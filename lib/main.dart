import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/app.dart';
import 'package:user_repository/user_repository.dart';


// App es responsable de proveer los repositorios de autenticación y usuario a toda la aplicación que seran consumidos por los widgets del AppView
void main() {
  runApp(
    App(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    ),
  );
}
