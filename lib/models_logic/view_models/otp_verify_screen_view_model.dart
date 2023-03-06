import 'package:banking_app/models_logic/models/user.dart' as bank_user;
import 'package:banking_app/screens/views/bank_home.dart';
import 'package:banking_app/screens/views/new_user.dart';
import 'package:banking_app/services/Local_Db/local_db.dart';
import 'package:banking_app/services/api_calls/auth_db.dart';
import 'package:banking_app/services/api_calls/auth_realtimeDb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class OtpVerifyViewModel{
  Auth auth = Auth();
  AuthRealtimeDb db = AuthRealtimeDb();
  checkOtp(String verifyId,String pin,String number,BuildContext context) async {
    final localDb=Provider.of<LocalDb>(context,listen: false);
    if (pin.length != 6) {
      return false;
    }
    List<dynamic> ans = await auth.signInWithOtp(verifyId, pin);
    if (ans[0] == true) {
      UserCredential user = ans[1];
      String tokken=ans[2];
      String uid = user.user?.uid ?? "";
      String expiry=ans[3];
      debugPrint(user.user?.uid ?? "");
      await db.createUserUponLogin(uid, number, ans[2]);  // logic to check weather user exists or not
      Map<String, dynamic> details = await db.getUserDetails(uid, ans[2]);
      if (details.containsKey('name')) { 
        bank_user.User user=bank_user.User.fromJSON(details);
        await localDb.saveUserToLocalDb(user);
        await localDb.saveTokkenToLocalDb(tokken,expiry);
        // save to bank home provider
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BankHome(),
            ),
            (route) => false);
      } else {                            // we have a new user
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => NewUser(
                id: uid,
                number: number,
                tokken: tokken,
                expiry: expiry,
              ),
            ),
            (route) => false);
      }
    }
    debugPrint('login ok');
    return ans[0];
  }

  showDiag(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Oops'),
          content: const Text('You entered wrong otp'),
          actions: <Widget>[
            TextButton(
              child: const Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}