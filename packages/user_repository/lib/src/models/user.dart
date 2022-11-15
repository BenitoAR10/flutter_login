import 'package:equatable/equatable.dart';

// La clase User extiende de Equatable para poder comparar objetos

class User extends Equatable{
  const User(this.id); // Constructor constante que recibe un id

  final String id;

  @override
  List<Object> get props => [id]; // get props es un metodo de Equatable que devuelve una lista de objetos
  
  static const empty = User('-'); // Creamos un usuario vacio
}