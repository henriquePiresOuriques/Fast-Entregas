import 'package:flutter/material.dart';
import 'package:tcc_henrique/app/domain/entities/profile.dart';
import 'package:tcc_henrique/app/domain/entities/user.dart';
import 'package:tcc_henrique/app/domain/entities/validate.dart';
import 'package:tcc_henrique/app/domain/usecases/login_usercase.dart';
import 'package:tcc_henrique/app/presentation/login/login_validate.dart';

class LoginController with ChangeNotifier {
  final LoginValidate loginValidate;
  final LoginUsecaseImpl loginUsecaseImpl;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String _emailError = '';
  String _passwordError = '';
  bool _emailIsValid;
  bool _passwordIsValid;
  bool _showPassword = false;
  bool _isloading = false;

  LoginController({this.loginValidate, this.loginUsecaseImpl});

  String get emailError => _emailError;
  String get passwordError => _passwordError;
  bool get emailIsValid => _emailIsValid;
  bool get passwordIsValid => _passwordIsValid;
  bool get showPassword => _showPassword;
  bool get isLoading => _isloading;

  bool _isError = false;
  bool get isError => _isError;
  String messageError;

  bool isValidForm() => _emailIsValid && _passwordIsValid;

  Validate validate;

  Profile profile;

  void emailValid(String email) {
    validate = loginValidate.validatingEmail(email);
    _emailError = validate.description;
    _emailIsValid = validate.valid;
    notifyListeners();
  }

  void passwordValid(String password) {
    validate = loginValidate.validatingPassword(password);
    _passwordError = validate.description;
    _passwordIsValid = validate.valid;
    notifyListeners();
  }

  void hidePassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  String errorText(bool valid, String error) {
    if (valid == null || valid) {
      return null;
    } else {
      return error;
    }
  }

  void _validatingFields() {
    emailValid(emailController.text);
    passwordValid(passwordController.text);
  }

  Future<bool> onPressed() async {
    _isloading = true;

    notifyListeners();
    _validatingFields();
    if (isValidForm()) {
      User user = User(
        email: emailController.text,
        password: passwordController.text,
      );

      final result = await loginUsecaseImpl.singIn(user);
      _isloading = false;
      notifyListeners();
      result.fold(
        (l) {
          _isError = true;
          notifyListeners();
        },
        (r) {
          profile = r;
          _isError = false;
          notifyListeners();
        },
      );
      _isloading = false;
      notifyListeners();

      if (result.isRight()) {
        return true;
      } else {
        return false;
      }
    } else {
      _isloading = false;
      notifyListeners();
      return false;
    }
  }
}
