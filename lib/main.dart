import 'dart:async';

import 'package:banking_app/models_logic/view_models/bank_home_view_model.dart';
import 'package:banking_app/screens/views/bank_home.dart';
import 'package:banking_app/screens/views/signup_screen.dart';
import 'package:banking_app/screens/views/splash.dart';
import 'package:banking_app/services/Local_Db/local_db.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LocalDb()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  bool isLoading = true;
  @override
  void didChangeDependencies() async {
    await Provider.of<LocalDb>(context, listen: false).getTokkenFromLocalDb();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
        isLoggedIn = Provider.of<LocalDb>(context, listen: false).isLoggedIn;
      });
      super.didChangeDependencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => isLoading
            ? const Splash()
            : (isLoggedIn ? BankHome() : const SignUpScreen()),
        '/bank_home': (context) => BankHome(),
      },
    );
  }
}
