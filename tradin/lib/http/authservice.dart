import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tradin/models/profile.dart';
import 'package:tradin/models/user.dart';

class AuthService extends ChangeNotifier {
  String request_id;
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
      return handleResponse(response, userDetails);
    } catch (e) {
      print('error found');
      print('$e');
      return e.toString();
    }
  }

  handleLogin(Map<String, dynamic> loginDetails) async {
    try {
      final response = await http.post(
        '$address/login/',
        body: {
          'identity': "${loginDetails['identity']}",
          'password': "${loginDetails['password']}",
        },
      );
      return handleResponse(response, loginDetails);
    } catch (e) {
      print('error found');
      print('$e');
      return e.toString();
    }
  }

  handleResponse(response, Map<String, dynamic> details) {
    // _user keep resting to null on signup success
    var footprint =
        details.containsKey('email') ? details['email'] : details['identity'];
    // print(response.body);
    _user = response.statusCode == 409
        ? null
        : User.fromJson(json.decode(response.body)['user']);
    if (_user?.email == footprint || _user?.phoneNumber == footprint) {
      // _saveLastAuthorizedPhoneNumber(_user.phoneNumber);
      _prefs.setString('user', json.encode(_user));
      return _user;
    } else {
      return null;
    }
  }

  requestPhoneVerification() async {
    _getUserFromSharedPreferences();
    print('phone number is: ${user.phoneNumber}');
    // try {
    //   final response = await http.post(
    //     '$address/get_code/',
    //     body: {
    //       'phone_number': user.phoneNumber,
    //     },
    //   );
    //   print(response.toString());
    //   request_id = json.decode(response.body)['request_id'];
    // } catch (e) {
    //   print('error found');
    //   print('$e');
    // }
  }

  verifyPhoneNumber(code) async {
    // try {
    //   final response = await http.post(
    //     '$address/verify_phone/',
    //     body: {
    //       'request_id': request_id,
    //       'code': code,
    //     },
    //   );
    //   print(response.body);
    // } catch (e) {
    //   print('error found');
    //   print('$e');
    //   return e.toString();
    // }
    return "successful";
  }

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
        entries.putIfAbsent(k, () => v);
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
}

class UserDetailsNotFound implements Exception {
  // can contain constructors, variables and methods
  String get errormessage => 'User Details not found';
}
