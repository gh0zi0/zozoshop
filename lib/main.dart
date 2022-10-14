import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zozoshop/screens/admin.dart';
import 'package:zozoshop/screens/home.dart';
import 'package:zozoshop/screens/register_screen.dart';
import 'package:zozoshop/screens/splash_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: const MyApp(),
    debugShowCheckedModeBanner: false,
    initialRoute: '/splash',
    routes: {
      '/splash': (context) => const SplashScreen(),
      '/register': (context) => const RegesterScreen(),
      '/home': (context) => const HomeScreen(),
      '/admin': (context) => const AdminScreen()
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
