import 'package:flutter/material.dart';

Widget submitButton(BuildContext context, String text) {
  final mediaQuery = MediaQuery.of(context).size;
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
    height: mediaQuery.height * 0.07,
    width: mediaQuery.width * 0.9,
    decoration: BoxDecoration(
        color: Colors.yellowAccent, borderRadius: BorderRadius.circular(15)),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15),
      ),
    ),
  );
}

Widget submitWaitButton(BuildContext context) {
  final mediaQuery = MediaQuery.of(context).size;
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
    height: mediaQuery.height * 0.07,
    width: mediaQuery.width * 0.9,
    decoration: BoxDecoration(
        color: Colors.yellowAccent, borderRadius: BorderRadius.circular(15)),
    child: const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
