import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EButton extends StatelessWidget {
  EButton({super.key, required this.title, required this.function});
  String title;
  Function function;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: const Color.fromARGB(255, 110, 213, 194)),
          onPressed: () {
            function();
          },
          child: Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          )),
    );
  }
}
