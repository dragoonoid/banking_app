import 'package:banking_app/models_logic/view_models/otp_verify_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String number;
  final String verificationId;
  const OtpVerificationScreen(
      {Key? key, required this.number, required this.verificationId})
      : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  OtpVerifyViewModel verifyViewModel = OtpVerifyViewModel();
  var pin = '-1';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: mediaQuery.height * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Verify Phone',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Code is sent to ${widget.number}',
                        style: const TextStyle(
                            color: Color.fromARGB(124, 43, 41, 41),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Expanded(child: Image.asset('assets/images/otpIcon.jpg')),
                      SizedBox(
                        child: Pinput(
                          length: 6,
                          showCursor: true,
                          onChanged: (x) {
                            debugPrint('com');
                            pin = x;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Didn't receive code?",
                            style: TextStyle(
                                color: Color.fromARGB(124, 43, 41, 41)),
                          ),
                          TextButton(
                            // TODO request code again
                            onPressed: () {},
                            child: const Text(
                              'Request Again',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    bool x = await verifyViewModel.checkOtp(
                      widget.verificationId,
                      pin,
                      widget.number,
                      context,
                    );
                    setState(() {
                      isLoading = false;
                    });
                    if (x == true) {
                      debugPrint('true');
                    } else {
                      verifyViewModel.showDiag(context);
                      debugPrint('false');
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    width: mediaQuery.width * 0.8,
                    height: mediaQuery.height * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.yellowAccent,
                    ),
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Center(
                            child: Text(
                              'Verify and Create Account',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                          ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
