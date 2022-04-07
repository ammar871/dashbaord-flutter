part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}


//login
class LoginAuthLoad extends AuthState {}

class LoginAuthSuccess extends AuthState {}
class LoginAuthError extends AuthState {}


//register
class RegisterAuthLoad extends AuthState {}

class RegisterAuthSuccess extends AuthState {}
class RegisterAuthError extends AuthState {}