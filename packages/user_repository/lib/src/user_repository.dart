// aqui consultariamos al usuario actual desde el backend
// esta clase contendra un unico metodo que nos devolvera el usuario actual 
import 'dart:async';

import 'package:user_repository/src/models/models.dart';
import 'package:uuid/uuid.dart';

// creamos la clase UserRepository
class UserRepository{

  User? _user; // declaramos una variable privada de tipo User 

  // creamos un metodo future que devuelve un User
  Future<User?> getUser() async {
    if (_user  != null){ // preguntamos si _user es diferente de null
                         // si es igual a null devolvemos un User vacio
      return _user;
    }
    // si no es igual a null devolvemos un User con un id aleatorio generado por la libreria uuid 
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(const Uuid().v4()),
    );
  }

}