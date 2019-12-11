import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tradin/models/user.dart';

class AuthService extends ChangeNotifier {
  static final host = '10.0.2.2';
  static final port = '5000';
  SharedPreferences _prefs;
  User _user;
  String get address => '$host:$port';
  User get user => _user;

  AuthService() {
    loadSharedPreferences();
  }

  loadSharedPreferences() async =>
      _prefs = await SharedPreferences.getInstance();

  userLoggedIn() {
    try {
      _user = loadUserProfileFromStorage();
    } catch (e) {
      print(e.toString());
    }
    return _user != null ? true : false;
  }

  getUserProfile() {
    if (_user == null) {
      try {
        return loadUserProfileFromStorage();
      } on UserDetailsNotFound {
        return loadUserProfileFromCloud();
      } catch (e) {
        print(e);
      }
    }
  }

  handleSignUp(Map<String, dynamic> userDetails) async {
    try {
      final result = await http.post('$address/create_user/', body: {
        'full_name': userDetails['fullName'],
        'email': userDetails['email'],
        'phoneNumber': userDetails['password'],
        'password': userDetails['password'],
      });
      print(result.body);
      _user = User.fromJson(json.decode(result.body));
    } catch (e) {
      print(e.message);
      return e.message;
    }
  }

  // handleLogin(loginDetails) async {
  //   try {
  //     final result = await _auth.signInWithEmailAndPassword(
  //         email: loginDetails['identity'], password: loginDetails['password']);
  //     // .timeout(Duration(seconds: 2), onTimeout: () =>AuthResult);
  //     final user = result?.user;
  //     print(user);
  //     return user;
  //   } catch (e) {
  //     print('${e.message}');
  //     return e.message;
  //   }
  // }

  logout() async {
    _prefs.clear();
    _user = null;
    notifyListeners();
  }

  loadUserProfileFromStorage() {
    final userProfile = {
      'email': _prefs.get('email'),
      'fullName': _prefs.get('fullName'),
      'phone': _prefs.get('phone'),
    };
    if (userProfile['email'] == _user.email) {
      print(userProfile);
      return Future.value(userProfile);
    }
    return throw UserDetailsNotFound();
  }

  loadUserProfileFromCloud() async {
    final String _email = _user?.email;
    if (user != null) {
      final userProfile = await Future.delayed(Duration(seconds: 2), () => {});
      _saveUserProfileToStorage(userProfile);
      return userProfile;
    }
  }

  void _saveUserProfileToStorage(Map<String, dynamic> userProfile) {
    _prefs.setString('email', userProfile['email']);
    _prefs.setString('fullName', userProfile['fullName']);
    _prefs.setString('phone', userProfile['phone']);
  }

  handleLogin(Map<String, String> loginDetails) {}
}

class UserDetailsNotFound implements Exception {
  // can contain constructors, variables and methods
  String get errormessage => 'User Details not found';
}
