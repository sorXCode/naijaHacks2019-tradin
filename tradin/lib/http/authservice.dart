import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tradin/models/profile.dart';
import 'package:tradin/models/user.dart';

class AuthService extends ChangeNotifier {
  static final host = '10.0.2.2';
  static final port = '5000';
  SharedPreferences _prefs;
  User _user;
  Profile _profile;
  String get address => 'http://$host:$port';
  User get user => _user;

  AuthService() {
    loadSharedPreferences();
    _getUserFromSharedPreferences();
  }

  _getUserFromSharedPreferences() async {
    if (_prefs?.containsKey('user') == true) {
      _user = User.fromJson(json.decode(_prefs.get('user')));
    }
  }

  loadSharedPreferences() async =>
      _prefs = await SharedPreferences.getInstance();

  userLoggedIn() {
    try {
      _user = loadUserProfileFromStorage();
    } catch (e) {
      // print(e.toString());
    }
    return _user != null ? true : false;
  }

  handleSignUp(Map<String, dynamic> userDetails) async {
    try {
      final response = await http.post(
        '$address/create_user/',
        body: {
          'full_name': "${userDetails['fullName']}",
          'email': "${userDetails['email']}",
          'phone_number': "${userDetails['phoneNumber']}",
          'password': "${userDetails['password']}",
        },
      );
      // _user keep resting to null on signup success
      _user = response.statusCode == 409
          ? null
          : User.fromJson(json.decode(response.body)['user']);
      if (_user?.displayName == userDetails['fullName']) {
        print(_user);
        // _saveLastAuthorizedPhoneNumber(_user.phoneNumber);
        _prefs.setString('user', json.encode(_user));
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

  getUserProfile() {
    if (_user == null) {
      _getUserFromSharedPreferences();
      // print(_user.displayName);
      // try {
      //   return loadUserProfileFromStorage();
      // } on UserDetailsNotFound {
      // return loadUserProfileFromCloud();
      // } catch (e) {
      //   print(e);
      // }
    }
    final fields = [
      "displayName",
      "email",
      "phoneNumber",
      "isPhoneVerified",
      "isEmailVerified",
    ];
    var entries = {};
    _user.toJson().map((k, v) {
      if (fields.contains(k)) {
        v ??= false;
        entries.putIfAbsent(k, ()=> v);
      }
      return MapEntry(k, v);
    });

    return Future.value(entries);
  }

  loadUserProfileFromStorage() {
    final userProfile = {
      'email': _prefs.get('email'),
      'fullName': _prefs.get('fullName'),
      'phone': _prefs.get('phone'),
    };
    if (userProfile['email'] == _user.email) {
      print(userProfile);
      var userprofile = _user.toJson();
      print(userprofile);
      return Future.value(userprofile);
    }
    return throw UserDetailsNotFound();
  }

  loadUserProfileFromCloud() async {
    if (_user != null) {
      final response = await http
          .post("$address/profile", body: {'identity': _user.phoneNumber});
      final _userProfile = Profile.fromJson(json.decode(response.body));
      _saveUserProfileToStorage(_userProfile);
      return _userProfile;
    }
  }

  // Muddy water
  _saveLastAuthorizedPhoneNumber(phoneNumber) {
    _prefs.setString('lastAuthorizedPhone', phoneNumber);
  }

  _getLastAuthorizedPhoneNumber(phoneNumber) {
    _prefs.getString('lastAuthorizedPhone');
  }

  void _saveUserProfileToStorage(Profile profile) {
    _prefs.setString('email', profile.email);
    _prefs.setString('fullName', profile.displayName);
    _prefs.setString('phone', profile.phoneNumber);
  }

  handleLogin(Map<String, String> loginDetails) {}
}

class UserDetailsNotFound implements Exception {
  // can contain constructors, variables and methods
  String get errormessage => 'User Details not found';
}
