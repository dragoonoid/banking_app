import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
abstract class AuthRealtimeDbAbstract{
  Future<void> createUserUponLogin(String id, String number, String tokken);
  Future<bool> createUserWithFullInfo(Map<String,dynamic> mp,String id,String tokken);
  Future<Map<String,dynamic>> getUserDetails(String uid, String tokken);
  Future<int> getUserPin(String uid,String tokken);
}

class AuthRealtimeDb extends AuthRealtimeDbAbstract{
  String ref = 'https://bank-app-add71-default-rtdb.firebaseio.com';
  @override
  createUserUponLogin(String id, String number, String tokken) async {
    final uri = Uri.parse('${ref}users/$id.json?auth=$tokken');
    Map<String, dynamic> mp = {
      'uId': id,
      'phone': number,
    };
    try {
      await http.put(uri, body: json.encode(mp));
    } on Exception catch (_) {
      debugPrint(_.toString());
    }
  }

  @override
  createUserWithFullInfo(Map<String,dynamic> mp,String id,String tokken) async {
    final uri = Uri.parse('$ref/users/$id.json?auth=$tokken');
    try {
      await http.put(uri, body: jsonEncode(mp));
      return true;
    } on Exception catch (_) {
      debugPrint('32');
      debugPrint(_.toString());
      return false;
    }
  }

  @override
  getUserDetails(String uid, String tokken) async {
    final uri = Uri.parse('$ref/users/$uid.json?auth=$tokken');
    Map<String,dynamic> mp={};
    try {
      var response = await http.get(uri);
      mp = json.decode(response.body);
      return mp;
    } on Exception catch (_) {
      debugPrint(_.toString());
      return mp;
    }
  }
  @override
  Future<int> getUserPin(String uid, String tokken)async {
    final uri = Uri.parse('$ref/users/$uid/pin.json?auth=$tokken');
    try{
      var response=await http.get(uri);
      var mp=json.decode(response.body);
      debugPrint(mp);
      return -1;
    }on Exception catch(e){
      debugPrint(e.toString());
      return -1;
    }

  }
}
