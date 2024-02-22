import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class UsernameChanged extends SignupEvent {
  final String username;

  const UsernameChanged({required this.username});

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'UsernameChanged { username :$username }';
}

class EmailChanged extends SignupEvent {
  final String email;

  const EmailChanged({required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email: $email }';
}

class PasswordChanged extends SignupEvent {
  final String password;

  const PasswordChanged({required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends SignupEvent {}
