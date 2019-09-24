import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_app/GraphQLApp.dart';
import 'package:my_app/GraphQLFile.dart';
import 'package:my_app/GraphQLIndex.dart';
import 'package:my_app/GraphQLUpload.dart';
import 'package:my_app/SplashScreen.dart';
import './layout_structure.dart';

import './counter.dart';
import './layout2.dart';
import './list.dart';
import './simulatorScreen1.dart';
import './simulatorScreen2.dart';
import 'bloc_delegate/SimpleBlocDelegate.dart';



void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}
  

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
        '/screen2': (context) => MyScreenTwo(),
        '/screen': (context) => SplashScreen(),
        '/gql': (context) => GraphQLIndex(),
        '/gqlApp': (context) => GraphQLApp(),
        '/gqlUpload': (context) => GraphQLUpload(),
        '/gqlFile': (context) => GraphQLFile()
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
          Expanded(
          child:GestureDetector(
            child: Image.asset(path,
            fit: BoxFit.cover,),
            onTap: () {
              Navigator.pushNamed(context, route);
            },
          )
        ),
          Container(
              color: Colors.grey[200],
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          maxCrossAxisExtent: 300,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            
            _buildGridTiles('assets/list.jpg', 'LIST', '/list'),
            _buildGridTiles('assets/counter.png', 'COUNTER', '/counter'),
            _buildGridTiles('assets/layout.jpg', 'STRUCTURE', '/layoutStructure'),
            _buildGridTiles('assets/lake.jpg', 'LAYOUT', '/layout'),
            _buildGridTiles('assets/screen.png', 'SCREEN-1', '/screen1'),
            _buildGridTiles('assets/screen.png', 'SCREEN-2', '/screen2'),
            _buildGridTiles('assets/login.png', 'LOGIN SCREEN', '/screen'),
            _buildGridTiles('assets/graphql.png', 'GRAPHQL', '/gql'),

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
