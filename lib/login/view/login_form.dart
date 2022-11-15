import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/login/login.dart';
import 'package:formz/formz.dart';

// El LoginForm es responsable de mostrar el formulario de inicio de sesión y de reaccionar a los cambios de estado del LoginBloc usando el BlocBuilder y blocListener.

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) { // pregutamos si el estado es un fallo de envio.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            ); // mostramos un SnackBar con el mensaje de error.
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username, // buildWhen nos permite controlar cuando se reconstruye el widget. En este caso solo se reconstruira cuando el estado del username cambie. 
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'), 
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'username',
            errorText: state.username.invalid ? 'invalid username' : null,
          ),
        );
      },
    );
  }
} // el widget _UsernameInput es un widget de tipo TextField que se encarga de mostrar el campo de texto para el username. El widget se encarga de escuchar los cambios de estado del LoginBloc usando el BlocBuilder y de actualizar el estado del LoginBloc cuando el usuario ingresa un username.

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
} // el widget _PasswordInput es muy similar al _UsernameInput, la unica diferencia es que el campo de texto es de tipo password. 

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
                child: const Text('Login'),
              );
      },
    );
  }
} // el widget _LoginButton es un widget de tipo ElevatedButton que se encarga de mostrar el boton de login. El widget se encarga de escuchar los cambios de estado del LoginBloc usando el BlocBuilder y de actualizar el estado del LoginBloc cuando el usuario presiona el boton de login.
