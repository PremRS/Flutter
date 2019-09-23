
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './ExitScreen.dart';

import 'WaitingScreen.dart';
import 'bloc/AuthenticationBloc.dart';

import 'bloc_event/AuthenticationEvent.dart';
import 'bloc_state/AuthenticationState.dart';
import 'login.dart';

import 'repository/UserRepository.dart';



class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState >(
        builder: (context, state) {
          if(state is AuthUninitialized) {
            return WaitingScreen();
          }
          if (state is AuthAuthenticated) {
            return ExitScreen();
          }
          if (state is AuthUnauthenticated) {
            return Login(userRepo: userRepository);
          }
          if(state is AuthLoading) {
            return WaitingScreen();
          }

          return SplashScreen();
        },
      ),
    );
  }
}


 class SplashScreen extends StatelessWidget{
  
  final userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    
 return Container(
   child: BlocProvider<AuthenticationBloc>(
      builder: (context) {
        return AuthenticationBloc(userRepo: userRepository)
          ..dispatch(AppStarted());
      },
      child: App(userRepository: userRepository),
 )
    
 );
  }
}