import 'package:flutter/material.dart';
import 'package:tcc_henrique/app/domain/entities/profile.dart';
import 'package:tcc_henrique/app/domain/entities/validate.dart';
import 'package:tcc_henrique/app/domain/usecases/register_usecase.dart';
import 'package:tcc_henrique/app/presentation/register/register_validate.dart';

class RegisterController with ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final districtController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final complementController = TextEditingController();
  final referenceController = TextEditingController();

  final RegisterValidate registerValidate;
  final RegisterUsecaseImpl registerUsecaseImpl;
  RegisterController({this.registerValidate, this.registerUsecaseImpl});

  String _nameError = '';
  String get nameError => _nameError;

  bool _nameisValid;
  bool get nameisValid => _nameisValid;

  String _emailError = '';
  String get emailError => _emailError;

  bool _emailIsValid;
  bool get emailIsValid => _emailIsValid;

  String _passwordError = '';
  String get passwordError => _passwordError;

  bool _passwordIsValid;
  bool get passwordIsValid => _passwordIsValid;

  String _confirmPasswordError = '';
  String get confirmPasswordError => _confirmPasswordError;

  bool _confirmPasswordIsValid;
  bool get confirmPasswordIsValid => _confirmPasswordIsValid;

  bool _showPassword = false;
  bool get showPassword => _showPassword;

  bool _showConfirmPassword = false;
  bool get showConfirmPassword => _showConfirmPassword;

  String _districtError = '';
  String get districtError => _districtError;

  String _streetError = '';
  String get streetError => _streetError;

  String _numberError = '';
  String get numberError => _numberError;

  bool _districtIsValid;
  bool get districtIsValid => _districtIsValid;

  bool _streetIsValid;
  bool get streetIsValid => _streetIsValid;

  bool _numberIsValid;
  bool get numberIsValid => _numberIsValid;

  Validate validate;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isError = false;
  bool get isError => _isError;

  void nameValid(String name) {
    validate = registerValidate.validatingName(name);
    _nameError = validate.description;
    _nameisValid = validate.valid;
    notifyListeners();
  }

  void emailValid(String email) {
    validate = registerValidate.validatingEmail(email);
    _emailError = validate.description;
    _emailIsValid = validate.valid;
    notifyListeners();
  }

  void passwordValid(String password) {
    validate = registerValidate.validatingPassword(password);
    _passwordError = validate.description;
    _passwordIsValid = validate.valid;
    notifyListeners();
  }

  void confirmPasswordValid(String confirmPassword) {
    validate = registerValidate.validatingConfirmPassword(
        confirmPassword, passwordController.text);
    _confirmPasswordError = validate.description;
    _confirmPasswordIsValid = validate.valid;
    notifyListeners();
  }

  void districtValid(String district) {
    validate = registerValidate.validatingField(district);
    _districtError = validate.description;
    _districtIsValid = validate.valid;
    notifyListeners();
  }

  void streetValid(String street) {
    validate = registerValidate.validatingField(street);
    _streetError = validate.description;
    _streetIsValid = validate.valid;
    notifyListeners();
  }

  void numberValid(String number) {
    validate = registerValidate.validatingField(number);
    _numberError = validate.description;
    _numberIsValid = validate.valid;
    notifyListeners();
  }

  String errorText(bool valid, String error) {
    if (valid == null || valid) {
      return null;
    } else {
      return error;
    }
  }

  void hidePassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  void hideConfirmPassword() {
    _showConfirmPassword = !_showConfirmPassword;
    notifyListeners();
  }

  void _validatingFields() {
    nameValid(nameController.text);
    emailValid(emailController.text);
    passwordValid(passwordController.text);
    confirmPasswordValid(confirmPasswordController.text);
    districtValid(districtController.text);
    streetValid(streetController.text);
    numberValid(numberController.text);
  }

  bool isValidAccessData() =>
      _emailIsValid &&
      _passwordIsValid &&
      _confirmPasswordIsValid &&
      _nameisValid &&
      _streetIsValid &&
      _numberIsValid &&
      districtIsValid;

  Future<bool> onPressed() async {
    _isLoading = true;
    notifyListeners();
    _validatingFields();
    if (isValidAccessData()) {
      Profile profile = Profile(
        name: nameController.text,
        password: passwordController.text,
        email: emailController.text,
        rua: streetController.text,
        numero: numberController.text,
        bairro: districtController.text,
        complemento: complementController.text ?? '',
        referencia: referenceController.text ?? '',
      );
      final result = await registerUsecaseImpl.createAccount(profile);
      _isLoading = false;
      notifyListeners();
      if (result.isRight()) {
        clearController();
        _isError = false;
        notifyListeners();
        return true;
      } else {
        _isError = true;
        notifyListeners();
        return false;
      }
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearController() {
    nameController.text = '';
    emailController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    districtController.text = '';
    streetController.text = '';
    numberController.text = '';
    complementController.text = '';
    referenceController.text = '';
  }
}
