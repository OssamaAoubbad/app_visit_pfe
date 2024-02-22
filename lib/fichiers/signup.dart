import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un compte'),
      ),
      body: BlocProvider(
        create: (context) => SignupBloc(),
        child: SignupForm(),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signupBloc = BlocProvider.of<SignupBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Nom d\'utilisateur'),
            onChanged: (value) => signupBloc.add(UsernameChanged(username: value)),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            onChanged: (value) => signupBloc.add(EmailChanged(email: value)),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(labelText: 'Mot de passe'),
            obscureText: true,
            onChanged: (value) => signupBloc.add(PasswordChanged(password: value)),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Soumettre le formulaire
              signupBloc.add(Submitted());
            },
            child: Text('Créer un compte'),
          ),
          SizedBox(height: 20),
          BlocBuilder<SignupBloc, SignupState>(
            builder: (context, state) {
              if (state is SignupLoading) {
                return CircularProgressIndicator();
              } else if (state is SignupSuccess) {
                // Rediriger vers une autre page après succès
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop(); // Retour à la page précédente
                });
              } else if (state is SignupFailure) {
                return Text(
                  'Erreur lors de la création du compte',
                  style: TextStyle(color: Colors.red),
                );
              }
              return Container(); // Par défaut, ne rien afficher
            },
          ),
        ],
      ),
    );
  }
}
