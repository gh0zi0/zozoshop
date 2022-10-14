import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var auth;

  check() async {
    auth = await FirebaseAuth.instance.currentUser?.uid ?? '';
    await Future.delayed(Duration(milliseconds: 1000));
    if (auth != '') {
      Navigator.popAndPushNamed(context, '/home');
    } else {
      Navigator.popAndPushNamed(context, '/register');
    }
  }

  @override
  void initState() {
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('lottie/splash.json',
            height: 200, width: 200, repeat: false),
      ),
    );
  }
}
