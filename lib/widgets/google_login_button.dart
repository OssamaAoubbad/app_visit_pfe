// lib/widgets/google_login_button.dart
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:app_visit_pfe/services/authentication_service.dart';
import 'package:app_visit_pfe/screens/home_screen.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print("hello ossama");
        User? user = await AuthenticationService().signInWithGoogle();
        print("page de google");
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
          );
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29.0),
        child: Image.asset(
          'assets/logo_google_with.jpg',
          width: 250.0,
          height: 100.0,
        ),
      ),
    );
  }
}
