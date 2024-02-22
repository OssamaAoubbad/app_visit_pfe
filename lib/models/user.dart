// models/user.dart
class User {
  final String uid;
  final String fullName;
  final String email;
  final String phoneNumber;

  User({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });

  // Constructeur par défaut
  User.defaultUser()
      : uid = '',
        fullName = '',
        email = '',
        phoneNumber = '';
}
