import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_app/bloc_state/LoginState.dart';
import 'package:my_app/repository/UserRepository.dart';

import 'bloc/AuthenticationBloc.dart';
import 'bloc/LoginBloc.dart';
import 'bloc_event/LoginEvent.dart';

class Login extends StatelessWidget {
  final UserRepository userRepo;
  

  Login({Key key, @required this.userRepo})
      : assert(userRepo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.red,
                  Colors.orange,
                  Colors.deepOrange,
                  Colors.blue,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.2, 0.4, 0.6, 0.9]),
          ),
          
          child: BlocProvider(
            builder: (context) {
              return LoginBloc(
                authBloc: BlocProvider.of<AuthenticationBloc>(context),
                userRepo: userRepo,
              );
            },
            child: Column(
              children: <Widget>[appBar(context), LoginFormBody(),],
            ),
          )),
          
    );
  }
}

Widget appBar(BuildContext context) => SafeArea(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pushNamed(context,'/');
            },
          ),
          Text('Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
          Icon(Icons.help, color: Colors.white),
        ],
      ),
    ));

Widget loginImage() => Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/flutter-logo.png'),
          )),
    );

class LoginFormBody extends StatefulWidget {
  @override
  _LoginFormBodyState createState() => _LoginFormBodyState();
}

class _LoginFormBodyState extends State<LoginFormBody> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLoginAttempt() {
      final user = _usernameController.text;
      final pass = _passwordController.text;
      print('In Login.dart  $user $pass');
      _loginBloc.dispatch(LoginAttempt(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
      
    }

    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginUnsuccessful) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
            bloc: _loginBloc,
            builder: (BuildContext context, LoginState state) {
              return Stack(
                children: <Widget>[
                  Form(
                      child: Container(
                    margin: EdgeInsets.only(top: 48),
                    padding: EdgeInsets.all(12),
                    child: Card(
                      elevation: 24,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Container(
                          margin: EdgeInsets.only(top: 16),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(24),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                          child: TextField(
                                        decoration: InputDecoration(
                                            labelText: 'Username',
                                            icon: Icon(
                                                Icons.supervised_user_circle)),
                                        controller: _usernameController,
                                      )),
                                    ],
                                  )),
                              Container(
                                padding: EdgeInsets.all(24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                        child: TextField(
                                      decoration: InputDecoration(
                                          labelText: 'Password',
                                          icon: Icon(Icons.lock)),
                                      controller: _passwordController,
                                      obscureText: true,
                                    ))
                                  ],
                                ),
                              ),
                              ButtonBar(
                                children: <Widget>[
                                  RaisedButton(
                                    child: Text('Login'),
                                    onPressed: 
                                    state is! LoginLoading ? _onLoginAttempt : null,
                                  ),
                                  RaisedButton(
                                    child: Text('Reset'),
                                    onPressed: () {
                                      _usernameController.text = '';
                                      _passwordController.text = '';
                                    },
                                  ),
                                  
                                ],
                              )
                            ],
                          )),
                    ),
                  )),
                  
                     Align(
                    alignment: Alignment.center,
                    child:loginImage(),
                  )
                  ,
                  
                ],
              );
           
            }));
  }
}
