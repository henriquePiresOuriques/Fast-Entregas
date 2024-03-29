extension StringExtension on String {
  bool isEmail() {
    final RegExp regex = RegExp(Patterns.checkIsValidEmail);
    return regex.hasMatch(this);
  }
}

class Patterns {
  static const checkIsValidEmail =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
}
