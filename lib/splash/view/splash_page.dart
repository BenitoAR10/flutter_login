import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
 
  // exponemos un método estático que nos permita navegar a la página de splash
  static Route<void> route(){
    return MaterialPageRoute<void>(builder: (_) => const SplashPage()); // retornamos la ruta de la página de splash
  }

  @override
  Widget build(BuildContext context) {
    // usaremos un scaffold que nos permita mostrar un indicador de progreso
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ); 
  }
}