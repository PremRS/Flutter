import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Counter'),
        ),
        body: Counter()
      );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;
  
  void increment() {
    setState(() {
      _counter++;
    });
  }

  void decrement() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Text('Counter'),
        Text(
          '$_counter',
          style: Theme.of(context).textTheme.display4,
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_upward),
              onPressed: increment,
            ),
            IconButton(
              icon: Icon(Icons.arrow_downward),
              onPressed: decrement,
            ),
          ],
        )
      ],
    )));
  }
}
