import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './layout_structure.dart';

import './counter.dart';
import './layout2.dart';
import './list.dart';
import './simulatorScreen1.dart';
import './simulatorScreen2.dart';

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
        '/layout': (context) => MyLayout(),
        '/screen1': (context) => MyScreenOne(),
        '/screen2': (context) => MyScreenTwo()
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

  bool likeStatus;

  final Set<String> likeSet = Set<String>();

  _buildGridTiles(String path, String label, String route) {
    likeStatus = likeSet.contains(label);
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Image.asset(path),
            onTap: () {
              Navigator.pushNamed(context, route);
            },
          ),
          Container(
              color: Colors.grey[100],
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                GestureDetector(
                  child: Icon(
                    (likeStatus ? Icons.favorite : Icons.favorite_border),
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () {
                    setState(() {
                      if (likeSet.contains(label)) {
                        likeStatus = false;
                        likeSet.remove(label);
                      } else {
                        likeStatus = true;
                        likeSet.add(label);
                      }
                    });
                  },
                ),
              ])),
        ],
      ),
    );
  }

  Widget _buildGrid() => GridView.extent(
          maxCrossAxisExtent: 350,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            _buildGridTiles('assets/list.jpg', 'LIST', '/list'),
            _buildGridTiles('assets/counter.png', 'COUNTER', '/counter'),
            _buildGridTiles(
                'assets/layout.jpg', 'STRUCTURE', '/layoutStructure'),
            _buildGridTiles('assets/lake.jpg', 'LAYOUT', '/layout'),
            _buildGridTiles('assets/screen.png', 'SCREEN-1', '/screen1'),
            _buildGridTiles('assets/screen.png', 'SCREEN-2', '/screen2')
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
                width: 350,
                height: 150,
                child: flutterImage,
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
