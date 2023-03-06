import 'dart:convert';

import 'package:banking_app/models_logic/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDbAbstract {
  Future<void> saveUserToLocalDb(User user);
  Future<void> saveTokkenToLocalDb(String tokken,String expiry);
  Future getUserFromLocalDb();  // user or null
  Future getTokkenFromLocalDb();// tokken or ""
  Future clearLocalDb();
  Future _getValueFromLocal(String key);
  Future _setValueToLoacl(String key,String value);
}

class LocalDb extends ChangeNotifier with LocalDbAbstract {
  String? tokken;
  User? _user;
  String expiry="2020-01-02 00:00:00.000";
  bool isLoggedIn = false;
  @override
  Future<void> saveUserToLocalDb(User user) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> mp = user.toJSON();
    final String s = jsonEncode(mp);
    prefs.setString('user', s);
    _user = user;
    debugPrint('User saved locally');
  }

  @override
  Future<void> saveTokkenToLocalDb(String tokken,String expiry) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tokken', tokken);
    prefs.setString('expiry', expiry);
    this.tokken = tokken;
    debugPrint('Tokken saved locally');
  }

  @override
  Future getUserFromLocalDb() async {
    final prefs = await SharedPreferences.getInstance();
    final String s = prefs.getString('user') ?? "";
    if (s != "") {
      Map<String, dynamic> mp = jsonDecode(s);
      User user = User.fromJSON(mp);
      debugPrint('Retrived user from local db');
      return user;
    }
    debugPrint('No user in local db');
    return "";
  }

  @override
  Future getTokkenFromLocalDb() async {
    final prefs = await SharedPreferences.getInstance();
    tokken = prefs.getString('tokken') ?? "";
    debugPrint(tokken);
    expiry=prefs.getString('expiry')??"2020-01-02 00:00:00.000";
    if(tokken==""){// || DateTime.parse(expiry).isBefore(DateTime.now())){
      debugPrint('false loged in');
      debugPrint('tokken=$tokken');
      debugPrint(expiry);
      isLoggedIn=false;
    }
    else{
      debugPrint('true logged in');
      debugPrint(tokken);
      isLoggedIn=true;
    }
    notifyListeners();
    return tokken;
  }

  @override
  Future clearLocalDb() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    isLoggedIn=false;
    tokken=null;
    //_user=null;
    notifyListeners();
  }
  
  @override
  Future _getValueFromLocal(String key) async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }
  
  @override
  Future _setValueToLoacl(String key, String value) async{
    final prefs = await SharedPreferences.getInstance();
     prefs.setString(key,value) ;
  }
}
