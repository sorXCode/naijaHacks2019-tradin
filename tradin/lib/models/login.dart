import 'package:flutter/material.dart';
import 'package:tradin/http/authservice.dart';
import 'package:tradin/models/system.dart';
import 'package:tradin/models/user.dart';

class LoginState extends ChangeNotifier {

  String _identity = '';
  String _password = '';
  bool _visiblePassword = false;
  //  TDDO: Status == !Result.processing
  Status _status = Status.idle;
  Result _result;
  String _errormessage;
  BuildContext _context;
  bool get visiblePassword => _visiblePassword;
  String get identity => _identity;
  String get password => _password;
  Status get status => _status;
  Result get result => _result;
  String get erroressage => _errormessage;
  AuthService _authService = AuthService();
  // bool get activate => _activate;

  Map<String, String> get loginDetails => {
        "identity": identity,
        "password": password,
      };

  updateIdentity(String identity) {
    _resetSwitches();
    // print('$identity');
    this._identity = identity;
    notifyListeners();
  }

  updatePassword(String password) {
    _resetSwitches();
    print("$password");
    this._password = password;
    notifyListeners();
  }

  togglePasswordVisibility() {
    _visiblePassword = !_visiblePassword;
    notifyListeners();
  }

  validateFields() =>
      loginDetails.values.fold(true, (prev, next) => prev && next.isNotEmpty);

  bool get activateLoginButton => validateFields();

_initswitches() {
    _result = Result.processing;
    _status = Status.busy;
    notifyListeners();
}
  _resetSwitches() {
    if (_errormessage != null && result != null) {
      print('reseting switches');
      _errormessage = null;
      _result = null;
    }
  }

resetFields(){
  updateIdentity('');
  updatePassword('');
}

  // TODO: DRY already in signup; make them a class method
  handleLogin(context) async {
    print('object');
    _initswitches();
    
    _context = context;
    notifyListeners();
    final response = await _authService.handleLogin(loginDetails);
    //  await Future.delayed(Duration(seconds: 2));
    handleResponse(_context, response);
    _status = Status.idle;
    notifyListeners();
  }

  // TODO: DRY already in signup; make them a class method
  handleResponse(context, response) {
    switch (response.runtimeType) {
      case User:
        _result = Result.success;
        Navigator.pushNamedAndRemoveUntil(context, 'home', ModalRoute.withName('home'));
        // Navigator.pushNamed(context, 'home');
        break;
      case String:
        _errormessage =  response.contains(RegExp(r'user|password|email'))? 'Incorrect Details' : 'Network Error';
        _result = Result.failed;
        break;
      // default:
      //   this._result = Result.failed;
    }
  }
}

// TODO: APPLY INHERITANCE for repeated methods: class methods to be