import 'package:banking_app/models_logic/models/user.dart';
import 'package:banking_app/screens/views/bank_home.dart';
import 'package:banking_app/services/Local_Db/local_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/api_calls/auth_realtimeDb.dart';

class NewUserViewModel {
  AuthRealtimeDb db = AuthRealtimeDb();
  validate(
    String id,
    String number,
    String tokken,
    String name,
    String email,
    String dob,
    String addhar,
    bool checkBox,
    BuildContext context,
    GlobalKey<FormState> key,
    String expiry,
  ) async {
    if (!key.currentState!.validate() || checkBox == false) {
      return false;
    }
    Map<String, dynamic> details = createMap(id, addhar, true,
        DateTime.now().toString(), dob, email, true, name, number, "1", "1");
    bool success = await db.createUserWithFullInfo(details, id, tokken);
    if (success == true) {
      // ignore: use_build_context_synchronously
      final localDb = Provider.of<LocalDb>(context, listen: false);
      User user = User.fromJSON(details);
      await localDb.saveUserToLocalDb(user);
      await localDb.saveTokkenToLocalDb(tokken,expiry);
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => BankHome(),
          ),
          (route) => false);
    } else {
      // TODO Verification failed
    }
    return true;
  }
}
