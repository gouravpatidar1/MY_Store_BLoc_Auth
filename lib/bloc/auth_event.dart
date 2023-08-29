import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object?> get props => [];

}
class LoginEvent extends AuthEvent{
  final String loginEmail;
  final String loginPassword;

  LoginEvent({
    required this.loginEmail,
    required this.loginPassword
    });

  @override
  List<Object> get props => [loginEmail,loginPassword]; 

  @override
  String toString() => 'LoginEvent { username: $loginEmail, password: $loginPassword}';
}

class RegisterUseEvent extends AuthEvent {
  final String emailValue;
  final String passwordValue;
  
  RegisterUseEvent({
    required this.emailValue,
    required this.passwordValue,
    });

  @override
  List<Object?> get props => [emailValue, passwordValue];

  @override
  String toString() => 'PerformRegister { username: $emailValue, password: $passwordValue }';

}