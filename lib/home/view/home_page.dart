import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/authentication/authentication.dart';

// HomePage es un widget de tipo Scaffold que muestra el id del usuario y un boton para cerrar sesion. El widget se encarga de escuchar los cambios de estado del AuthenticationBloc usando el BlocBuilder y de actualizar el estado del AuthenticationBloc cuando el usuario presiona el boton de logout. 
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(
              builder: (context) {
                final userId = context.select(
                  (AuthenticationBloc bloc) => bloc.state.user.id,
                );
                return Text('UserID: $userId');
              },
            ),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
            ),
          ],
        ),
      ),
    );
  }
} 
