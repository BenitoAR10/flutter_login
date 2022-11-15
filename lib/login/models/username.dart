import 'package:formz/formz.dart';
// validamos que el nombre de usuario no esté vacío
enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure(''); // pure es un estado que nos permite saber si el campo está vacío
  const Username.dirty([super.value = '']) : super.dirty(); //  dirty es un estado que nos permite saber si el campo está lleno

  @override
  UsernameValidationError? validator(String? value){
    return value?.isNotEmpty == true ? null : UsernameValidationError.empty; // retornamos un error si el campo está vacío
  }
}