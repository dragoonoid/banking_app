class User {
  final String uid;
  final String addharNo;
  final bool addharVerified;
  final String createdOn;
  final String dob;
  String email;
  final bool emailVerified;
  final String name;
  String phone;
  String primaryCard;
  String profileImage;
  User(
      {required this.uid,
      required this.addharNo,
      required this.addharVerified,
      required this.createdOn,
      required this.dob,
      required this.email,
      required this.emailVerified,
      required this.name,
      required this.phone,
      required this.primaryCard,
      required this.profileImage});

  factory User.fromJSON(Map<String, dynamic> mp) {
    return User(
      uid: mp['uId'],
      addharNo: mp['addhar_no'],
      addharVerified: mp['addhar_verified'],
      createdOn: mp['created_on'],
      dob: mp['dob'],
      email: mp['email'],
      emailVerified: mp['email_verified'],
      name: mp['name'],
      phone: mp['phone'],
      primaryCard: mp['primary_card'],
      profileImage: mp['profile_image'],
    );
  }
  Map<String, dynamic> toJSON() {
    Map<String, dynamic> mp = {};
    mp['uId'] = uid;
    mp['addhar_no'] = addharNo;
    mp['addhar_verified'] = addharVerified;
    mp['created_on'] = createdOn;
    mp['dob'] = dob;
    mp['email'] = email;
    mp['email_verified'] = emailVerified;
    mp['name'] = name;
    mp['phone'] = phone;
    mp['primary_card'] = primaryCard;
    mp['profile_image'] = profileImage;
    return mp;
  }
}

Map<String, dynamic> createMap(
    String uid,
    String addharNo,
    bool addharVerified,
    String createdOn,
    String dob,
    String email,
    bool emailVerified,
    String name,
    String phone,
    String primaryCard,
    String profileImage) {
  Map<String, dynamic> mp = {};
  mp['uId'] = uid;
  mp['addhar_no'] = addharNo;
  mp['addhar_verified'] = addharVerified;
  mp['created_on'] = createdOn;
  mp['dob'] = dob;
  mp['email'] = email;
  mp['email_verified'] = emailVerified;
  mp['name'] = name;
  mp['phone'] = phone;
  mp['primary_card'] = primaryCard;
  mp['profile_image'] = profileImage;
  return mp;
}
