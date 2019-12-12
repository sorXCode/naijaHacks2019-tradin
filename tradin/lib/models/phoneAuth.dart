import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:tradin/http/authservice.dart';
import 'package:tradin/models/system.dart';

class PhoneAuth extends ChangeNotifier {
  String _code;
  Status _status = Status.idle;
  Result _result;
  BuildContext _context;
  AuthService _authService = AuthService();

  updateCode(String code) {
    _code = code;
    notifyListeners();
  }

  _initswitches() {
    _result = Result.processing;
    _status = Status.busy;
    notifyListeners();
  }

  handleSubmission(context) async {
    _initswitches();
    _context = context;
    notifyListeners();
    final response = await _authService.verifyPhoneNumber(_code);
    handleResponse(response);
    _status = Status.idle;
    notifyListeners();
  }

  handleResponse(response) {
    // body = response.body
  }

}
