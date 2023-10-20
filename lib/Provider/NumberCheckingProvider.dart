
import 'package:flutter/cupertino.dart';

class PhoneNumberModel {
  String number = "";
  bool showError = false;

  void updateNumber(String value) {
    number = value;
    showError = false;
  }
}

class NumberProvider extends ChangeNotifier{

  PhoneNumberModel _phoneNumberModel = PhoneNumberModel();
  bool _isInternetConnected = true;


  PhoneNumberModel get phoneNumberModel => _phoneNumberModel;
  bool get isInternetConnected => _isInternetConnected;

  void updatePhoneNumber(String value) {
    _phoneNumberModel.updateNumber(value);
    notifyListeners();
  }

  void showError() {
    _phoneNumberModel.showError = true;
    notifyListeners();
  }

  void updateInternetStatus(bool isConnected) {
    _isInternetConnected = isConnected;
    notifyListeners();
  }
}

