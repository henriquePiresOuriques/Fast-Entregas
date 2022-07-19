import 'package:tcc_henrique/app/domain/entities/validate.dart';

class HomeValidate {
  Validate validatingField(String value) {
    if (value.isEmpty) {
      return Validate(valid: false, description: 'Campo obrigatório');
    } else {
      return Validate(valid: true, description: '');
    }
  }
}
