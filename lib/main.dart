import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
//import 'dart:io';
import 'package:app_visit_pfe/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCF41sR9ZncH6f42jJOWh2DZZUgGofouRA",
      appId: "1:801976923665:web:2b6002c0c602bf54dba3b0",
      messagingSenderId: "801976923665",
      projectId: "app-visit-pfe",
      storageBucket: "app-visit-pfe.appspot.com",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}
