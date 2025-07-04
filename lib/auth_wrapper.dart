import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskflows/lib/home_page.dart';
import 'package:taskflows/sign_in_page.dart';
// Make sure these files exist and contain HomePage and SignInPage widgets

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const HomePage(); // show home page if logged in
        } else {
          return const SignInPage(); // otherwise show login
        }
      },
    );
  }
}

// Make sure you have HomePage and SignInPage widgets defined in their respective files.
