import 'package:flutter_bloc/flutter_bloc.dart';

// Événements
import 'signup_event.dart';
// États
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial());

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is UsernameChanged) {
      yield SignupInitial();
    } else if (event is EmailChanged) {
      yield SignupInitial();
    } else if (event is PasswordChanged) {
      yield SignupInitial();
    } else if (event is Submitted) {
      yield SignupLoading();

      // Simuler un appel à une API (ici une pause de 2 secondes)
      await Future.delayed(Duration(seconds: 2));

      // Simuler un succès ou un échec aléatoire
      bool success = true; // Modifier pour tester le succès ou l'échec

      if (success) {
        yield SignupSuccess();
      } else {
        yield SignupFailure();
      }
    }
  }
}
