import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/login/login.dart';

 
// LoginPage sera el responsable de exponer la ruta asi como de crear y proporcinar el LoginBloc al login_form.

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() { // creamos la ruta para la pagina de login.
    return MaterialPageRoute<void>(builder: (_) => const LoginPage()); // retornamos una nueva instancia de MaterialPageRoute que recibe como parametro un widget de tipo LoginPage.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding( // padding para darle un poco de espacio al formulario.
        padding: const EdgeInsets.all(12),
        child: BlocProvider( // bloc provider para proveer el LoginBloc al LoginForm.
          create: (context) {
            return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: const LoginForm(),
        ),
      ),
    );
  }
}
