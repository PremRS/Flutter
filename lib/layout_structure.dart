import 'package:flutter/material.dart';

class MyLayoutStructure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Layout Structure'),
      ),
      body: Layout(),
    );
  }
}

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  
  static final ratingStars = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.star, color: Colors.green[500], size: 12),
      Icon(Icons.star, color: Colors.green[500], size: 12),
      Icon(Icons.star, color: Colors.green[500], size: 12),
      Icon(Icons.star, color: Colors.black, size: 12),
      Icon(Icons.star, color: Colors.black, size: 12),
    ],
  );

  static final ratingReview = Text(
    '18 Reviews',
    style: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 12,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w500,
    ),
  );

static final layoutTitle = Text(
    'Strawberry Pavlova Recipe',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontFamily: 'Georgia',
      fontSize: 14,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w600,

    ),
  );

  static final layoutParagraph = Text(
    'Pavlova is a meringue-based dessert named after the Russian ballerina '
          'Anna Pavlova. Pavlova features a crisp crust and soft, light inside, '
          'topped with fruit and whipped cream.',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontFamily: 'Georgia',
      fontSize: 14,
      letterSpacing: 0.4,
    ),
  );
 static final descTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
      letterSpacing: 0.5,
      fontSize: 12,
      height: 2,
    );

    // DefaultTextStyle.merge() allows you to create a default text
    // style that is inherited by its child and all subsequent children.
    static final iconList = DefaultTextStyle.merge(
      style: descTextStyle,
      child: Container(
        decoration: BoxDecoration(
        border: Border.all(color: Colors.black)
         ),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(Icons.kitchen, color: Colors.green[500]),
                Text('PREP:'),
                Text('25 min'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.timer, color: Colors.green[500]),
                Text('COOK:'),
                Text('1 hr'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.restaurant, color: Colors.green[500]),
                Text('FEEDS:'),
                Text('4-6'),
              ],
            ),
          ],
        ),
      ),
    );

  static final ratingBar = Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.red)
         ),
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ratingStars,
          ratingReview,
        ],
      ));

   final leftColumn = Container(
     decoration: BoxDecoration(
        border: Border.all(color: Colors.black)
         ),
    padding: const EdgeInsets.all(8.0),
    child:Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      layoutTitle,
      layoutParagraph,
      ratingBar,
      iconList
    ]
  )
  );

  final mainImage = Image.asset(
    'assets/pavlova.jpg',
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black)
         ),
        height: 400,
        margin: EdgeInsets.fromLTRB(5, 40, 5, 30),
        child:Card(
          elevation: 24,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
              child:Container( 
                child:leftColumn
              )
              ),
              Expanded(
              child:Container(
                height: 400,
                child:mainImage,
                )
              ),
            ],),
        ),
    );
  }
}