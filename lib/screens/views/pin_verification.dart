import 'package:banking_app/screens/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinVerification extends StatefulWidget {
  const PinVerification({Key? key}) : super(key: key);

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
  String pin1 = "";
  String pin2="";
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const FlutterLogo(
            size: 100,
          ),
          Pinput(
            length: 6,
            showCursor: true,
            obscureText: true,
            onChanged: (x) {
              pin1 = x;
            },
          ),
          Pinput(
            length: 6,
            showCursor: true,
            obscureText: true,
            onChanged: (x) {
              pin2 = x;
            },
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                isLoading=true;
              });
              if(pin1.length==6 && pin1==pin2){
                debugPrint(pin1);
              }
              setState(() {
                isLoading=false;
              });
            },
            child: isLoading ?submitWaitButton(context):submitButton(context, 'Generate Pin'),
          ),
        ],
      ),
    );
  }
}
