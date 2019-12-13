class User {
  String _uid;
  String _displayName;
  String _photoUrl;
  String _email;
  String _phoneNumber;
  String _token;
  bool _isEmailVerified;
  bool _isPhoneVerified;

  User(
      {String uid,
      String displayName,
      String photoUrl,
      String email,
      String phoneNumber,
      String token,
      bool isEmailVerified,
      bool isPhoneVerified}) {
    this._uid = uid;
    this._displayName = displayName;
    this._photoUrl = photoUrl;
    this._email = email;
    this._phoneNumber = phoneNumber;
    this._token = token;
    this._isEmailVerified = isEmailVerified;
    this._isPhoneVerified = isPhoneVerified;
  }

  String get uid => _uid;
  set uid(String uid) => _uid = uid;
  String get displayName => _displayName;
  set displayName(String displayName) => _displayName = displayName;
  String get photoUrl => _photoUrl;
  set photoUrl(String photoUrl) => _photoUrl = photoUrl;
  String get email => _email;
  set email(String email) => _email = email;
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String phoneNumber) => _phoneNumber = phoneNumber;
  String get token => _token;
  set token(String token) => _token = token;
  bool get isEmailVerified => _isEmailVerified;
  set isEmailVerified(bool isEmailVerified) =>
      _isEmailVerified = isEmailVerified;
  bool get isPhoneVerified => _isPhoneVerified;
  set isPhoneVerified(bool isPhoneVerified) =>
      _isPhoneVerified = isPhoneVerified;

  User.fromJson(Map<String, dynamic> json) {
    _uid = json['uid'];
    _displayName = json['displayName'];
    _photoUrl = json['photoUrl'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _token = json['token'];
    _isEmailVerified = json['isEmailVerified'];
    _isPhoneVerified = json['isPhoneVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this._uid;
    data['displayName'] = this._displayName;
    data['photoUrl'] = this._photoUrl;
    data['email'] = this._email;
    data['phoneNumber'] = this._phoneNumber;
    data['token'] = this._token;
    data['isEmailVerified'] = this._isEmailVerified;
    data['isPhoneVerified'] = this._isPhoneVerified;
    return data;
  }
}
