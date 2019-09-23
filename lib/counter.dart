import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import './bloc/CounterBloc.dart';

class MyCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Counter'),
        ),
        body:BlocProvider<CounterBloc>(builder: (context) => CounterBloc(),
        child: CounterPage(),
        )
      );
        
  }
}

class CounterPage extends StatelessWidget{

@override
Widget build(BuildContext context){

  final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

  return BlocBuilder<CounterBloc, int>(
        builder: (context, count) {
          return numberCounter(counterBloc, context, count);
});
}

numberCounter(CounterBloc counterBloc,BuildContext context, int counter) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Counter'),
        Text(
          '$counter',
          style: Theme.of(context).textTheme.display4,
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_upward),
              onPressed: () {
                  counterBloc.dispatch(CounterEvent.increment);
              } 
            ),
            IconButton(
              icon: Icon(Icons.arrow_downward),
              onPressed: () {
                counterBloc.dispatch(CounterEvent.decrement);
              } 
            ),
          ],
        )
      ],
    );
}
