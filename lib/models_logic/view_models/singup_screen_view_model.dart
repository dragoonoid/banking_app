import 'package:banking_app/services/api_calls/auth_db.dart';
import 'package:flutter/material.dart';
class SignUpScreenViewModel{
  Auth auth=Auth();
  Future<void> submit(String num,BuildContext context)async {
    await auth.sendOtp(num,context);
  }
}