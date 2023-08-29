import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
   @override
  List<Object?> get props => [];
}

class Initialstate extends AuthState {}

class loadingstate extends AuthState {}

class LogInsuccessstate extends AuthState {}

class Registrationsuccessstate extends AuthState{}

class Errorstate extends AuthState{}