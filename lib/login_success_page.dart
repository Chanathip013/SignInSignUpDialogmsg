import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';

class LoginSuccessPage extends StatelessWidget {
  LoginSuccessPage({super.key});

  final user = FirebaseAuth.instance.currentUser;

  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
    const MyApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: const Text('SHOPS'),
        actions: [
          IconButton(
            onPressed: signOutUser,
            icon: const Icon(Icons.login, size: 30,),
          ),
        ],
      ),
      body: Text("Hello, " + user!.email.toString(),),
    );
  }
}