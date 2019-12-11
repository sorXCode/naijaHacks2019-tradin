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
  String get address => 'http://$host:$port';
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
      final result = await http.post(
        '$address/create_user/',
        body: {
          'full_name': "${userDetails['fullName']}",
          'email': "${userDetails['fullName']}",
          'phone_number': "${userDetails['fullName']}",
          'password': "${userDetails['fullName']}",
        },
      );
      // DiRTY HACK.. FIX
      _user = User.fromJson(json.decode(result.body)['user']);
      if (_user.displayName == userDetails['fullName']) {
        _saveUserProfileToStorage(_user);
        return _user;
      } else {
        return null;
      }
    } catch (e) {
      print('error found');
      print('$e');
      return e.toString();
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
    // if (user != null) {
    //   final userProfile = await Future.delayed(Duration(seconds: 2), () => {});
    //   _saveUserProfileToStorage(userProfile);
    //   return userProfile;
    // }
  }

  void _saveUserProfileToStorage(User user) {
    _prefs.setString('email', user.email);
    _prefs.setString('fullName', user.displayName);
    _prefs.setString('phone', user.phoneNumber);
  }

  handleLogin(Map<String, String> loginDetails) {}
}

class UserDetailsNotFound implements Exception {
  // can contain constructors, variables and methods
  String get errormessage => 'User Details not found';
}
