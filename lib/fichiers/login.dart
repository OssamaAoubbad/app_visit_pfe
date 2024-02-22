import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_visit_pfe/fichiers/google.dart';
import 'signup.dart';

import 'package:app_visit_pfe/fichiers/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _login() async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Si l'utilisateur est authentifié avec succès, naviguez vers la page suivante
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResponsiveNavBarPage()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      print('Error: $_errorMessage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
                      'TechnoVisit',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true, // Ajouter une couleur de fond au champ de texte
                fillColor:
                    Colors.grey[200], // Couleur de fond du champ de texte
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Bordure arrondie du champ de texte
                ),
              ),
            ),
            SizedBox(
                height:
                    20), // Ajouter un espace entre le contenu et les boutons

            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true, // Ajouter une couleur de fond au champ de texte
                fillColor:
                    Colors.grey[200], // Couleur de fond du champ de texte
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Bordure arrondie du champ de texte
                ),
              ),
              obscureText:
                  true, // Masquer le texte pour le champ du mot de passe
            ),

            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Définir la couleur de fond du bouton
                onPrimary:
                    Colors.white, // Définir la couleur du texte du bouton
                padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0), // Définir le rembourrage du bouton
                textStyle: TextStyle(
                    fontSize: 18), // Définir le style de texte du bouton
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(29.0), // Définir la forme du bouton
                ),
              ),
              child: Text('login'),
            ),
            GestureDetector(
  onTap: () async {
    // Créer une instance de la classe LoginPageGoogle
    LoginPageGoogle loginPageGoogle = LoginPageGoogle();
    
    // Appeler la méthode handleSignInWithGoogle sur l'instance créée
    final User? user = await loginPageGoogle.createState().handleSignInWithGoogle();
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResponsiveNavBarPage()),
      );
    }
  },
  child: ClipRRect(
    borderRadius: BorderRadius.circular(29.0), // Rayon de bordure
    child: Image.asset(
      'assets/logo_google_with.jpg', // Chemin vers l'image du logo de Google
      width: 250.0, // Largeur de l'image
      height: 100.0, // Hauteur de l'image
    ),
  ),
),

            SizedBox(height: 8.0),
            GestureDetector(
              onTap: () {
                // Ajouter votre logique pour réinitialiser le mot de passe ici
              },
              child: Text(
                'Forget Password?',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage()),
                    );
                // Ajouter votre logique pour naviguer vers la page d'inscription ici
              },
              child: Text(
                'Register to create an account',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            SizedBox(height: 8.0),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
