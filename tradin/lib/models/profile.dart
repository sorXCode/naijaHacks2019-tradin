class Profile {
  String _displayName;
  String _photoUrl;
  String _email;
  String _phoneNumber;
  bool _isEmailVerified;
  bool _isPhoneVerified;
  String _rating;
  String _usertype;
  String _completedTrades;
  String _skills;
  String _certificates;
  String _jobsOffered;
  String _review;

  Profile(
      {String displayName,
      String photoUrl,
      String email,
      String phoneNumber,
      bool isEmailVerified,
      bool isPhoneVerified,
      String rating,
      String usertype,
      String completedTrades,
      String skills,
      String certificates,
      String jobsOffered,
      String review}) {
    this._displayName = displayName;
    this._photoUrl = photoUrl;
    this._email = email;
    this._phoneNumber = phoneNumber;
    this._isEmailVerified = isEmailVerified;
    this._isPhoneVerified = isPhoneVerified;
    this._rating = rating;
    this._usertype = usertype;
    this._completedTrades = completedTrades;
    this._skills = skills;
    this._certificates = certificates;
    this._jobsOffered = jobsOffered;
    this._review = review;
  }

  String get displayName => _displayName;
  set displayName(String displayName) => _displayName = displayName;
  String get photoUrl => _photoUrl;
  set photoUrl(String photoUrl) => _photoUrl = photoUrl;
  String get email => _email;
  set email(String email) => _email = email;
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String phoneNumber) => _phoneNumber = phoneNumber;
  bool get isEmailVerified => _isEmailVerified;
  set isEmailVerified(bool isEmailVerified) =>
      _isEmailVerified = isEmailVerified;
  bool get isPhoneVerified => _isPhoneVerified;
  set isPhoneVerified(bool isPhoneVerified) =>
      _isPhoneVerified = isPhoneVerified;
  String get rating => _rating;
  set rating(String rating) => _rating = rating;
  String get usertype => _usertype;
  set usertype(String usertype) => _usertype = usertype;
  String get completedTrades => _completedTrades;
  set completedTrades(String completedTrades) =>
      _completedTrades = completedTrades;
  String get skills => _skills;
  set skills(String skills) => _skills = skills;
  String get certificates => _certificates;
  set certificates(String certificates) => _certificates = certificates;
  String get jobsOffered => _jobsOffered;
  set jobsOffered(String jobsOffered) => _jobsOffered = jobsOffered;
  String get review => _review;
  set review(String review) => _review = review;

  Profile.fromJson(Map<String, dynamic> json) {
    _displayName = json['displayName'];
    _photoUrl = json['photoUrl'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _isEmailVerified = json['isEmailVerified'];
    _isPhoneVerified = json['isPhoneVerified'];
    _rating = json['rating'];
    _usertype = json['usertype'];
    _completedTrades = json['completedTrades'];
    _skills = json['skills'];
    _certificates = json['certificates'];
    _jobsOffered = json['jobs offered'];
    _review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this._displayName;
    data['photoUrl'] = this._photoUrl;
    data['email'] = this._email;
    data['phoneNumber'] = this._phoneNumber;
    data['isEmailVerified'] = this._isEmailVerified;
    data['isPhoneVerified'] = this._isPhoneVerified;
    data['rating'] = this._rating;
    data['usertype'] = this._usertype;
    data['completedTrades'] = this._completedTrades;
    data['skills'] = this._skills;
    data['certificates'] = this._certificates;
    data['jobs offered'] = this._jobsOffered;
    data['review'] = this._review;
    return data;
  }
}
