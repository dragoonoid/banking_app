import 'package:banking_app/models_logic/view_models/new_user_view_model.dart';
import 'package:flutter/material.dart';

class NewUser extends StatefulWidget {
  final String id;
  final String number;
  final String tokken;
  final String expiry;
  const NewUser(
      {Key? key, required this.id, required this.number, required this.tokken, required this.expiry})
      : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final key = GlobalKey<FormState>();
  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController dobCont = TextEditingController();
  TextEditingController addharCont = TextEditingController();
  NewUserViewModel newUserViewModel = NewUserViewModel();
  bool checkBox = false;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: const Center(
                    child: Text(
                      'Welcome to Apna Bank',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: media.height * 0.5,
                  child: Form(
                    key: key,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(
                            controller: nameCont,
                            decoration: const InputDecoration(
                              label: Text(
                                'Full Name',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.blue,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.length < 5) {
                                return 'Please Enter full Name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: dobCont,
                            decoration: const InputDecoration(
                              label: Text(
                                'DOB',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              prefixIcon: Icon(
                                Icons.date_range_outlined,
                                color: Colors.blue,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.datetime,
                          ),
                          TextFormField(
                            controller: emailCont,
                            decoration: const InputDecoration(
                              label: Text(
                                'Email',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  !value.contains('@gmail.com') ||
                                  value.length < 14) {
                                return 'Please Enter full Email';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: addharCont,
                            decoration: const InputDecoration(
                              label: Text(
                                'Addhar Number',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              prefixIcon: Icon(
                                Icons.account_balance,
                                color: Colors.blue,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.length != 16) {
                                return 'Please Enter full Addhar Number';
                              }
                              return null;
                            },
                          ),
                        ]),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        value: checkBox,
                        onChanged: (_) {
                          if (_ != null) {
                            setState(() {
                              checkBox = _;
                            });
                          }
                        }),
                    const Text('Agree With  '),
                    const Text(
                      'Terms & Conditions',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => newUserViewModel.validate(
                      widget.id,
                      widget.number,
                      widget.tokken,
                      nameCont.text,
                      emailCont.text,
                      dobCont.text,
                      addharCont.text,
                      checkBox,
                      context,
                      key,widget.expiry),
                  child: Container(
                    height: media.height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.blue),
                    child: const Center(
                      child: Text('Validate and Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
