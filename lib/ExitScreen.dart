
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/AuthenticationBloc.dart';
import 'bloc_event/AuthenticationEvent.dart';

class ExitScreen extends StatelessWidget {

   @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          GestureDetector(
          child:Icon(Icons.exit_to_app),
          onTap: () => authenticationBloc.dispatch(LoggedOut())
          
          )
        ],
      ),
      body: Container(
        child: Center(
            
          child: Text('Welcome To Exit Screen'),
        ),
      ),
    );
  }
}