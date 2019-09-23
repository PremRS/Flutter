
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {

  LoginEvent([List props = const[]]) : super(props);
}

class LoginAttempt extends LoginEvent {

  final String username;
  final String password;

  LoginAttempt({
    @required this.username,
    @required this.password
  }): super([username,password]);

  @override
  String toString() => 'LoginAttempt {username : $username, password: $password}';
}