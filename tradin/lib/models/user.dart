class User {
  String _uid;
  String _displayName;
  String _photoUrl;
  String _email;
  String _phoneNumber;
  String _isEmailVerified;
  String _isPhoneVerified;

  User(
      {String uid,
      String displayName,
      String photoUrl,
      String email,
      String phoneNumber,
      String isEmailVerified,
      String isPhoneVerified}) {
    this._uid = uid;
    this._displayName = displayName;
    this._photoUrl = photoUrl;
    this._email = email;
    this._phoneNumber = phoneNumber;
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
  String get isEmailVerified => _isEmailVerified;
  set isEmailVerified(String isEmailVerified) =>
      _isEmailVerified = isEmailVerified;
  String get isPhoneVerified => _isPhoneVerified;
  set isPhoneVerified(String isPhoneVerified) =>
      _isPhoneVerified = isPhoneVerified;

  User.fromJson(Map<String, dynamic> json) {
    _uid = json['uid'];
    _displayName = json['displayName'];
    _photoUrl = json['photoUrl'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
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
    data['isEmailVerified'] = this._isEmailVerified;
    data['isPhoneVerified'] = this._isPhoneVerified;
    return data;
  }
}
