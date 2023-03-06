import 'package:banking_app/services/Local_Db/local_db.dart';
import 'package:banking_app/services/api_calls/auth_db.dart';
import 'package:flutter/cupertino.dart';


class BankHomeViewModel {
  Auth auth=Auth();
  LocalDb localDb=LocalDb();
  void signOut(BuildContext context){
    auth.signOut();
    localDb.clearLocalDb();
    Navigator.pushNamedAndRemoveUntil(context, '/',ModalRoute.withName('/'));
  }
  
}