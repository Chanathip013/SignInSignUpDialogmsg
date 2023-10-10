import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_screen/components/my_textfield.dart';
import 'package:onboarding_screen/components/my_button.dart';
import 'package:onboarding_screen/components/my_iconbutton.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordagainController = TextEditingController();

  createUserWithEmailAndPassword() async {
      try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }  on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code} ');
      print(e.message);

    if (e.code == 'invalid-password') {
      print('please sign up with the same password.');

    } else if (e.code == 'EMAIL_IN_USE') {
      print('This account is already exist.');
    }
  }
  }

void signUpUser() async {
    if(emailController.text != "" && passwordController.text != "") {
      print("Try again!");
    } else {
    print("Please input your email and password.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding:const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Form(
          child: Column(
            children: [
              const Spacer(),
              Text(
                "Ready to get started?", 
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
              const SizedBox(height: 10,),
              Text(
                "Please sign up with your name, email and password",
               textAlign: TextAlign.center,
               style: GoogleFonts.lato(
                 textStyle: Theme.of(context).textTheme.displaySmall,
                 fontSize: 18,
                 fontWeight: FontWeight.w300,
                 fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                controller: nameController,
                hintText: 'Enter your name',
                obscureText: false,
                labelText: 'Name',
              ),
              const SizedBox(
                height: 18,
              ),
              MyTextField(
                controller: emailController,
                hintText: 'Enter your email',
                obscureText: false,
                labelText: 'Email',
              ),
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'Enter your password',
                obscureText: true,
                labelText: 'Password',
              ),
                const SizedBox(
                height: 18,
              ),
              MyTextField(
                controller: passwordagainController,
                hintText: 'Comfirm your password',
                obscureText: true,
                labelText: 'Comfirm Password',
              ),
              const Spacer(),

              MyButton(onTap: createUserWithEmailAndPassword, hintText: 'Register'),
              const SizedBox(height: 25,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ),
                     Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyIconButton(imagePath: 'assets/images/google-icon-2048x2048-czn3g8x8.png'),
                  SizedBox(width: 10,),
                  MyIconButton(imagePath: 'assets/images/152752.png'),
                ],
              ),
              const Spacer(),       
            ],
          ),
        ),
      ),
    );    
  }

         void showErrorMessage(BuildContext context, String message) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
               title: Text('Error'),
              content: Text(message),
                actions: <Widget>[
                 TextButton(
                   onPressed: () {
                    Navigator.of(context).pop();
                   },
                    child: Text('OK'),
                 ),
               ],
             );
           },
         );
       }    
    }