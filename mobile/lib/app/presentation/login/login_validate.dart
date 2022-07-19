import 'package:tcc_henrique/app/domain/entities/validate.dart';
import 'package:tcc_henrique/app/core/extensions/string_extension.dart';

class LoginValidate {
  Validate validatingEmail(String email) {
    bool response = email.isEmail();
    if (email.isEmpty) {
      return Validate(valid: response, description: 'Campo obrigatório');
    } else if (!response) {
      return Validate(
          valid: response, description: 'Por favor, informe um email válido');
    } else {
      return Validate(valid: response, description: '');
    }
  }

  Validate validatingPassword(String password) {
    if (password.isEmpty) {
      return Validate(valid: false, description: 'Campo obrigatório');
    } else if (password.length < 6) {
      return Validate(valid: false, description: 'Senha incorreta');
    } else {
      return Validate(valid: true, description: '');
    }
  }
}
