import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_app/layout_structure.dart';

import 'counter.dart';
import 'layout2.dart';
import 'list.dart';

void main() => (runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tuts',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Flutter Tutorial '),
        '/list': (context) => MyList(),
        '/counter': (context) => MyCounter(),
        '/layoutStructure': (context) => MyLayoutStructure(),
        '/layout': (context) => MyLayout()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final flutterImage = Image.asset(
    'assets/flutter.png',
    fit: BoxFit.cover,
  );

  _buildGridTiles(String path, String label, String route) => GestureDetector(
        child: Container(
            child: Column(
          children: <Widget>[
            Image.asset(path),
            Container(
                color: Colors.grey[100],
                padding: EdgeInsets.all(6),
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                  ),
                  Icon(
                    Icons.thumb_up,
                    color: Theme.of(context).primaryColor,
                    size: 18,
                  )
                ])),
          ],
        )),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      );

  Widget _buildGrid() => GridView.extent(
          maxCrossAxisExtent: 250,
          padding: const EdgeInsets.all(4),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            _buildGridTiles('assets/list.jpg', 'LIST', '/list'),
            _buildGridTiles('assets/counter.png', 'COUNTER', '/counter'),
            _buildGridTiles('assets/layout.jpg', 'STRUCTURE', '/layoutStructure'),
            _buildGridTiles('assets/lake.jpg', 'LAYOUT', '/layout')
          ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          margin: EdgeInsets.all(5),
          child: Card(
              child: Column(
            children: <Widget>[
              Container(
                child: Expanded(
                  child: flutterImage,
                ),
              ),
              Expanded(
                child: Container(
                  child: _buildGrid(),
                ),
              ),
            ],
          ))),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
