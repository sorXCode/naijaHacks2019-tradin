import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  static final host = '10.0.2.2';
  static final port = '5000';
  String get address => '$host:$port';

  SharedPreferences _prefs;


  AuthService() {
    getUser();
    loadSharedPreferences();
  }

  getUser() async {
    _user = await _auth.currentUser();
    return _user;
  }

  loadSharedPreferences() async =>
      _prefs = await SharedPreferences.getInstance();

  userLoggedIn() {
    if (_user == null) {
      getUser();
    }
    print(user);
    return _user != null ? true : false;
  }

  getUserProfile() {
    _user ??= getUser();
    try {
      return loadUserProfileFromStorage();
    } on UserDetailsNotFound {
      return loadUserProfileFromCloud();
    } catch (e) {
      print(e);
    }
  }

  handleSignUp(Map<String, dynamic> userDetails) async {
    try {
      final result = await _auth.createUser(
        fullName: userDetails['fullName'],
        email: userDetails['email'],
        phoneNumber: userDetails['password'],
        password: userDetails['password'],
      );
      print(result);
      // .timeout(Duration(seconds: 2), onTimeout: () =>AuthResult);
      final user = result?.user;

      if (user != null) {
        return user;
      }
    } catch (e) {
      // 'er'.contains;
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
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  loadUserProfileFromStorage() {
    final userProfile = {
      'email': _prefs.get('email'),
      'fullName': _prefs.get('fullName'),
      'phone': _prefs.get('phone'),
    };
    if (userProfile['email'] == _user?.email) {
      print(userProfile);
      return Future.value(userProfile);
    }
    return throw UserDetailsNotFound();
  }

  loadUserProfileFromCloud() async {
    final String _email = _user?.email;
    if (user != null) {
      final userProfile = await _userCollectionReference
          .where('email', isEqualTo: _email)
          .limit(1)
          .getDocuments()
          .then((userDocument) => userDocument.documents[0].data)
        ..remove('password');

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
