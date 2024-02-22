import 'dart:io';
//import 'package:app_visit_pfe/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'login.dart';
import 'package:app_visit_pfe/fichiers/sign__upp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCF41sR9ZncH6f42jJOWh2DZZUgGofouRA",
        appId: "1:801976923665:web:2b6002c0c602bf54dba3b0",
        messagingSenderId: "801976923665",
        projectId: "app-visit-pfe",
        storageBucket: "app-visit-pfe.appspot.com",
      ),
    );
  } else if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCF41sR9ZncH6f42jJOWh2DZZUgGofouRA",
        appId: "1:801976923665:android:2b6002c0c602bf54dba3b0",
        messagingSenderId: "801976923665",
        projectId: "app-visit-pfe",
        storageBucket: "app-visit-pfe.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Visit'),
      ),
      backgroundColor: Colors.white, // Définir la couleur de fond sur blanc
      body: Align(
        alignment: Alignment.topCenter, // Aligner le contenu en haut du parent
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0), // Ajouter de la marge en haut
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Centrer les enfants horizontalement
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0), // Espacer l'image de la société du nom de la société
                      child: Image.asset(
                        'assets/logo.jpg',
                        width: 250,
                        height: 250,
                      ),
                    ),
                    Text(
                      'TechnoVisit',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4), // Ajouter un espace entre le nom de la société et la description
                    Text(
                      'Bienvenue dans notre Service ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40), // Ajouter un espace entre le contenu et les boutons
              ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  },
  style: ElevatedButton.styleFrom(
    primary:Colors.blueAccent, // Définir la couleur de fond du bouton
    onPrimary: Colors.white, // Définir la couleur du texte du bouton
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Définir le rembourrage du bouton
    textStyle: TextStyle(fontSize: 18), // Définir le style de texte du bouton
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(29.0), // Définir la forme du bouton
    ),
  ),
  child: Text('Se connecter'),
),

              SizedBox(height: 10), // Ajouter un espace entre les boutons
             ElevatedButton(
                  onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUppPage()),
                );
                    },
  style: ElevatedButton.styleFrom(
    primary: Colors.blueAccent, // Définir la couleur de fond du bouton
    onPrimary: Colors.white, // Définir la couleur du texte du bouton
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Définir le rembourrage du bouton
    textStyle: TextStyle(fontSize: 18), // Définir le style de texte du bouton
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0), // Définir la forme du bouton
    ),
  ),
  child: Text('creer un compte'),
),

            ],
          ),
        ),
      ),
    );
  }
}
