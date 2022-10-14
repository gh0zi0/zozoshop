import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zozoshop/components/e_button.dart';
import 'package:zozoshop/components/edit_text.dart';
import 'package:zozoshop/components/t_button.dart';

class RegesterScreen extends StatefulWidget {
  const RegesterScreen({super.key});

  @override
  State<RegesterScreen> createState() => _RegesterScreenState();
}

class _RegesterScreenState extends State<RegesterScreen> {
  final GlobalKey<FormState> key = GlobalKey();
  var email = TextEditingController(),
      password = TextEditingController(),
      name = TextEditingController(),
      signIn = true,
      loading = false;

  changeState() {
    setState(() {
      signIn = !signIn;
    });
  }

  auth() async {
    if (!key.currentState!.validate()) {
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      var auth = FirebaseAuth.instance;
      var store = FirebaseFirestore.instance;
      if (signIn) {
        await auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        await store
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get()
            .then((value) {
          if (value['user']) {
            Navigator.popAndPushNamed(context, '/home');
          } else {
            Navigator.popAndPushNamed(context, '/admin');
          }
        });
      } else {
        await auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        await store
            .collection('users')
            .doc(auth.currentUser!.uid)
            .set({'name': name.text, 'user': true});
        Navigator.popAndPushNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 75,
              ),
              Image.asset(
                'images/brand.png',
                height: 200,
                width: 200,
              ),
              Text(
                signIn ? 'Sign In' : 'Sign Up',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              EditTextFiled(
                hint: 'Email',
                icon: Icons.email,
                controller: email,
                secure: false,
                validator: (val) {
                  if (val!.isEmpty || !val.contains('@'))
                    return 'Enter valid email';
                },
              ),
              EditTextFiled(
                hint: 'Password',
                secure: true,
                icon: Icons.password,
                controller: password,
                validator: (val) {
                  if (val!.isEmpty)
                    return 'Enter a password at least 6 characters';
                },
              ),
              AnimatedOpacity(
                opacity: signIn ? 0 : 1,
                duration: const Duration(milliseconds: 500),
                child: EditTextFiled(
                  hint: 'Name',
                  secure: false,
                  icon: Icons.person,
                  controller: name,
                  validator: (val) {
                    if (val!.isEmpty && !signIn)
                      return 'Please enter your name';
                  },
                ),
              ),
              SizedBox(
                height: signIn ? 50 : 75,
              ),
              TButton(
                  title: signIn
                      ? 'Don\'t have account? Sign Up'
                      : 'Already have account? Sign In',
                  function: changeState),
              loading
                  ? const CircularProgressIndicator()
                  : EButton(
                      title: signIn ? 'Sign In' : 'Sign Up',
                      function: auth,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
