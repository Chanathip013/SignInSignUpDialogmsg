import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_screen/components/my_textfield.dart';
import 'package:onboarding_screen/components/my_textbutton.dart';
import 'package:onboarding_screen/components/my_button.dart';
import 'package:onboarding_screen/components/my_iconbutton.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signInUser() async {
    if(emailController.text != "" && passwordController.text != "") {
      print("Try again!");
    } else {
    print("Please input your email and password.");
    }
  }

signInWithEmailAndPassword() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }  on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code} ');
      print(e.message);

    if (e.code == 'invalid-email') {
      print('No user found for that email.');

    } else if (e.code == 'INVAILD_LOGIN_CREDENTIALS') {
      print('Wrong password provided for that user.');
    }
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
                "Hello, ready to get started?", 
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
                "Please sign in with your email and password",
               textAlign: TextAlign.center,
               style: GoogleFonts.lato(
                 textStyle: Theme.of(context).textTheme.displaySmall,
                 fontSize: 16,
                 fontWeight: FontWeight.w300,
                 fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                controller: emailController,
                hintText: 'Enter your email',
                obscureText: false,
                labelText: 'Email',
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'Enter your password',
                obscureText: true,
                labelText: 'Password',
              ),
              const SizedBox(
                height: 20,
              ),
              const MyTextButton(labelText: 'Forgot password?', pageRoute: 'forgot',),
              const SizedBox(
                height: 25,
              ),
              MyButton(onTap: signInWithEmailAndPassword, hintText: 'Sign in'),
              const SizedBox(height: 25,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                     Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade700,
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

              const SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?', style: GoogleFonts.lato(
                       textStyle: Theme.of(context).textTheme.displaySmall,
                       fontSize: 16,
                       fontWeight: FontWeight.w500,
                       fontStyle: FontStyle.italic,
                       ),
                     ),
                      const MyTextButton(labelText: 'Register now', pageRoute: 'register',),
                    ],
                  ),
                ),
               const Spacer(),       
              ],
            ),
          ),
        ),
      );    
    }
    
  Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Error Dialog Example'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                bool credentialsAreIncorrect = true;

                if (credentialsAreIncorrect) {
                  showErrorMessage(context, 'Wrong username or password.');
                }
              },
              child: Text('Sign In'),
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