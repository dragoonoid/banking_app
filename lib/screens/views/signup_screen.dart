import 'package:banking_app/models_logic/view_models/singup_screen_view_model.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final numberCont = TextEditingController();

  final countryCont = TextEditingController();

  bool isLoading = false;
  SignUpScreenViewModel signUpModel=SignUpScreenViewModel();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: mediaQuery.height * 0.8,
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Expanded(
                              child:
                                  Image.asset('assets/images/bank_front.jpg'),
                            ),
                            Column(
                              children: const [
                                Text(
                                  'Welcome',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Join Us on a journey of online banking',
                                  style: TextStyle(
                                      color: Color.fromARGB(124, 43, 41, 41),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.green, width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      decoration: const InputDecoration(
                                          hintText: '+xx',
                                          counterText: '',
                                          border: InputBorder.none),
                                      controller: countryCont,
                                      maxLength: 3,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.green, width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: TextField(
                                      decoration: const InputDecoration(
                                          hintText: 'Enter 10 digit number',
                                          counterText: '',
                                          border: InputBorder.none),
                                      controller: numberCont,
                                      maxLength: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        debugPrint('send otp');
                        await signUpModel.submit(countryCont.text + numberCont.text,context);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        height: mediaQuery.height * 0.07,
                        width: mediaQuery.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.yellowAccent,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Center(
                          child: Text(
                            'Send Otp',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
