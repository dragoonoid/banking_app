
import 'package:banking_app/screens/views/otp_verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
abstract class AuthAbstract{
  Future<List<dynamic>> signInWithOtp(String verificationId, String otp);
  Future sendOtp(String number, BuildContext context);
}


class Auth extends AuthAbstract{
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<List<dynamic>> signInWithOtp(String verificationId, String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    UserCredential? response;
    try {
      response = await auth.signInWithCredential(credential);
      String? token = await auth.currentUser?.getIdToken();
      String? expiry=DateTime.now().add(const Duration(hours: 1)).toString();
      debugPrint(response.toString());
      return [true, response, token,expiry];
    } on Exception catch (_) {
      debugPrint(response.toString());
      debugPrint(_.toString());
      return [false];
    }
  }

  // Future getNewToken(String token) async {
  //   String url =
  //       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=$apiKey';
  //   var uri = Uri.parse(url);
  //   try {
  //     var response = await http.post(uri,
  //         body: json.encode({
  //           'token': token,
  //           'returnSecureToken': true,
  //         }));
  //     Map<String, String> mp = json.decode(response.body);
  //     print(mp['refreshToken']);
  //   } on Exception catch (_) {}
  // }

  @override
  Future sendOtp(String number, BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) {
      },
      verificationFailed: (FirebaseAuthException e) {
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerificationScreen(
                verificationId: verificationId,
                number: number,
              ),
            ),);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
      },
    );
  }

  Future signOut() async {
    await auth.signOut();
  }
}
