import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUppPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUppPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isSigningUp = false;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSigningUp = true;
      });

      try {
        // Create a new user with Firebase Auth
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Get the UID of the user
        String uid = userCredential.user!.uid;

        // Save additional information in Firestore with the user's UID as the key
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'fullName': _fullNameController.text.trim(),
          'phoneNumber': _phoneNumberController.text.trim(),
          // Add other information if needed
        });

        // Navigate to the home page or any other page after successful registration
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        print(e);
        // Handle registration errors
        setState(() {
          _isSigningUp = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                labelText: 'Full Name',
                filled: true, // Ajouter une couleur de fond au champ de texte
                fillColor:
                    Colors.grey[200], // Couleur de fond du champ de texte
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Bordure arrondie du champ de texte
                ),
              ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
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
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    // You can add more validation logic for email format if needed
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                labelText: 'Phone Number',
                filled: true, // Ajouter une couleur de fond au champ de texte
                fillColor:
                    Colors.grey[200], // Couleur de fond du champ de texte
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Bordure arrondie du champ de texte
                ),
              ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    // You can add more validation logic for phone number format if needed
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true, // Ajouter une couleur de fond au champ de texte
                    fillColor:Colors.grey[200], // Couleur de fond du champ de texte
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10.0), // Bordure arrondie du champ de texte
                ),
              ),
        
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    // You can add more validation logic for password strength if needed
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                labelText: 'Confirm Password',
                filled: true, // Ajouter une couleur de fond au champ de texte
                fillColor:
                    Colors.grey[200], // Couleur de fond du champ de texte
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Bordure arrondie du champ de texte
                ),
              ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _isSigningUp ? null : _signUp,
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
                  child: _isSigningUp ? CircularProgressIndicator() : Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
