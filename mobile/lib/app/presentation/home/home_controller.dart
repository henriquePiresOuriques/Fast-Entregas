import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc_henrique/app/domain/entities/address_home.dart';
import 'package:tcc_henrique/app/domain/entities/selected_item.dart';
import 'package:tcc_henrique/app/domain/entities/validate.dart';
import 'package:tcc_henrique/app/presentation/home/home_validate.dart';

class HomeController with ChangeNotifier {
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final complementController = TextEditingController();
  final referenceController = TextEditingController();

  final HomeValidate homeValidate;

  HomeController({this.homeValidate});

  String _streetError = '';

  String get streetError => _streetError;

  String _numberError = '';
  String get numberError => _numberError;

  String _referenceError = '';
  String get referenceError => _referenceError;

  bool _streetIsValid;
  bool get streetIsValid => _streetIsValid;

  bool _numberIsValid;
  bool get numberIsValid => _numberIsValid;

  bool _referenceIsValid;
  bool get referenceIsValid => _referenceIsValid;

  Validate validate;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void streetValid(String street) {
    validate = homeValidate.validatingField(street);
    _streetError = validate.description;
    _streetIsValid = validate.valid;
    notifyListeners();
  }

  void numberValid(String number) {
    validate = homeValidate.validatingField(number);
    _numberError = validate.description;
    _numberIsValid = validate.valid;
    notifyListeners();
  }

  void referenceValid(String reference) {
    validate = homeValidate.validatingField(reference);
    _referenceError = validate.description;
    _referenceIsValid = validate.valid;
    notifyListeners();
  }

  String errorText(bool valid, String error) {
    if (valid == null || valid) {
      return null;
    } else {
      return error;
    }
  }

  void selectedItem(SelectedItem selectedItem, List<SelectedItem> itens) {
    for (var item in itens) {
      item.isSelected = false;
    }
    selectedItem.isSelected = true;
    selectedItemMock = selectedItem;
    notifyListeners();
  }

  String toCurrency(double value) =>
      NumberFormat.simpleCurrency(locale: 'pt-BR').format(value);

  void _validatingFields() {
    referenceValid(referenceController.text);
    streetValid(streetController.text);
    numberValid(numberController.text);
  }

  SelectedItem selectedItemMock;
  AddressHome addressHome;

  bool isValidAccessData() =>
      _streetIsValid && _numberIsValid && _referenceIsValid;

  bool onPressed() {
    _validatingFields();
    if (isValidAccessData() && selectedItemMock != null) {
      addressHome = AddressHome(
        price: selectedItemMock.price,
        district: selectedItemMock.name,
        street: streetController.text,
        number: numberController.text,
        complement: complementController.text,
        reference: referenceController.text,
      );
      return true;
    } else {
      return false;
    }
  }
}
