import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tradin/http/authservice.dart';
import 'package:tradin/models/system.dart';
import 'package:tradin/models/user.dart';

class SignUpState extends ChangeNotifier {
  String _fullName = '';
  String _phone = '';
  String _email = '';
  String _password = '';
  bool _visiblePassword = false;
  bool _agreed = false;
  Status _status = Status.idle;
  Result _result;
  String _errormessage;
  BuildContext _context;
  AuthService _authService = AuthService();

  Status get status => _status;
  String get fullName => _fullName;
  String get phone => _phone;
  String get email => _email;
  String get password => _password;
  bool get visiblePassword => _visiblePassword;
  bool get agreed => _agreed;
  Result get result => _result;
  String get errormessage => _errormessage;
  bool get emailError => _emailError();
  Map<String, dynamic> get userDetails => {
        "fullName": fullName.trim(),
        "phoneNumber": phone.trim(),
        "email": email.trim(),
        "password": password.trim(),
      };

  bool get activateSignUpButton => validateFields();

  _resetInputs() {
    _fullName = '';
    _phone = '';
    _email = '';
    _password = '';
    _visiblePassword = false;
    _agreed = false;
    _status = Status.idle;
  }

  // class method
  _resetSwitches() {
    if (_errormessage != null && result != null) {
      print('reseting switches');
      _errormessage = null;
      _result = null;
    }
  }

  reset() {
    _resetInputs();
    _resetSwitches();
  }

  updateFullName(String fullName) async {
    _resetSwitches();
    print(fullName);
    this._fullName = fullName;
    notifyListeners();
  }

  updatePhone(String phone) {
    _resetSwitches();
    print(phone);
    this._phone = phone;
    notifyListeners();
  }

  updateEmail(String email) {
    _resetSwitches();
    print(email);
    this._email = email;
    notifyListeners();
  }

  updatePassword(String password) {
    _resetSwitches();
    this._password = password;
    print(password);
    notifyListeners();
  }

  updateAgreed(bool agreed) {
    this._agreed = agreed;
  }

  togglePasswordVisibility() {
    _visiblePassword = !_visiblePassword;
    notifyListeners();
  }

// HANDLESIGNUP METHOD FIRST TWOS CAN BE DIVIDED ::::: startprocess()&& IDKY
  validateFields() =>
      userDetails.values.fold(true, (prev, next) => prev && next.isNotEmpty) &&
      agreed;

  _emailError() {
    if (_errormessage?.contains('email') != null) {
      return true;
    }
    return false;
  }

  Future userSignUp(BuildContext context) async {
    _result = Result.processing;
    _context = context;
    _status = Status.busy;
    notifyListeners();
    // await Future.delayed(Duration(seconds: 2));
    var response = await _authService.handleSignUp(userDetails);
    handleResponse(response);
    _status = Status.idle;
    notifyListeners();
  }

  handleResponse(response) {
    print(response);
    switch (response.runtimeType) {
      case User:
        _result = Result.success;
        Navigator.pushNamedAndRemoveUntil(_context, 'phoneAuth', ModalRoute.withName('login'));
        break;
      case String:
        _errormessage = response;
        _result = Result.failed;
        break;
    default:
      this._result = Result.failed;
    }
  }
}
