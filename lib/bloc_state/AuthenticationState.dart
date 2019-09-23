
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {}

class AuthUninitialized extends AuthenticationState{

  @override
  String toString() => 'AuthUninitialized';
}

class AuthAuthenticated extends AuthenticationState{

  @override
  String toString() => 'AuthAuthenticated';
}

class AuthUnauthenticated extends AuthenticationState{

  @override
  String toString() => 'AuthUnauthenticated';
}

class AuthLoading extends AuthenticationState{

  @override
  String toString() => 'AuthLoading';
}