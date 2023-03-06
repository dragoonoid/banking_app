import 'package:banking_app/models_logic/view_models/bank_home_view_model.dart';
import 'package:flutter/material.dart';

class BankHome extends StatelessWidget {
  BankHome({Key? key}) : super(key: key);

  BankHomeViewModel bankHomeViewModel=BankHomeViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: ()=>bankHomeViewModel.signOut(context),
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ))
      ]),
    );
  }
}
