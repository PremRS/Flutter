import 'package:flutter/material.dart';

class MyScreenTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              // Color.fromRGBO(237, 48, 59, 1),
              Color.fromRGBO(240, 62, 118, 1),
              Color.fromRGBO(240, 62, 118, 1),
              Color.fromRGBO(240, 62, 118, 1),
              Color.fromRGBO(255, 145, 103, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            stops: [0.1,0.4,0.6, 0.9]),
      ),
      child: Column(children: [
        appBar(context),
      ]),
    ));
  }
}

Widget appBar(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
      child: Row(
        children: [
          Icon(
            Icons.menu,
            color: Colors.white,
          ),

          Expanded(
            child: Text(
              'Blog Articles',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          // IconButton(
          //   onPressed: null,
          //  icon:
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          // ),
          Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ],
      ),
    );

class BlogBody extends StatefulWidget {
  @override
  _BlogBodyState createState() => _BlogBodyState();
}

class _BlogBodyState extends State<BlogBody> {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}
