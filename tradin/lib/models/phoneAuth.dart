import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:tradin/http/authservice.dart';
import 'package:tradin/models/system.dart';

class PhoneAuthState extends ChangeNotifier {
  String _code = "";
  Status _status = Status.idle;
  Result _result;
  BuildContext _context;
  AuthService _authService = AuthService();
  bool error = false;
  String errorMessage;

  String get code => _code;
  bool get canSubmit => _canSubmit();
  Status get status => _status;

  updateCode(String code) {
    _resetErrorMessage();
    _code = _code.length < 4 ? _code + code : _code;
    notifyListeners();
  }

  deleteLast() {
    _resetErrorMessage();
    final length = _code.length;
    _code = length > 0 ? _code.substring(0, length - 1) : _code;
    notifyListeners();
  }

  _resetErrorMessage() {
    if (errorMessage != null) {
      errorMessage = null;
    }
  }

  _initswitches() {
    _result = Result.processing;
    _status = Status.busy;
    notifyListeners();
  }

  bool _canSubmit() {
    return _code.length == 4 ? true : false;
  }

  handleSubmission(context) async {
    _initswitches();
    _context = context;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 1500));
    final response = await _authService.verifyPhoneNumber(_code);
    print(response.toString());
    handleResponse(response);
    _status = Status.idle;
    notifyListeners();
  }

  handleResponse(response) {
    // body = response.body
    if (response.contains('success')) {
      Navigator.pushNamedAndRemoveUntil(
          _context, 'home', ModalRoute.withName('home'));
    } else {
      errorMessage = 'Incorrect Code';
      // notifyListeners();
    }
  }
}
