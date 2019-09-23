import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WaitingScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return Material(
          child: Scaffold(
        appBar: AppBar(
          title: Text('Please Wait')
          
        ),
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            CircularProgressIndicator(
              backgroundColor: Colors.blue,
              
              
            ),
            Divider(),
            Text('Please wait while screen is loading!'),
          ],
        ),),
      ),
    );
  }
}