import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.power_settings_new),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.popAndPushNamed(context, '/register');
          },
        ),
      ),
      body: Center(
        child: Text('Welcome'),
      ),
    );
  }
}
