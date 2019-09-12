import 'package:flutter/material.dart';

class MyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Layout'),
        ),
        body: myNewLayout(context));
  }
}

Widget myNewLayout(BuildContext context) {
 
 Color color = Theme.of(context).primaryColor;

  final headerImage = Image.asset(
    'assets/lake.jpg',
    height:240,
    fit: BoxFit.cover,
  );

  final titleArea = Container(
      padding: EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Oeshincahn Lake CampGround',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Text(
                  'Kanderstag, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                )
              ])),
          Icon(Icons.star, color: Colors.red[500]),
          Text('41')
        ],
      ));

Column _buildInformationIcons(IconData icon,Color buttonColor,String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        icon,
        color: buttonColor,
      ),
      Container(
        padding: EdgeInsets.only(top:8),
        child: Text(
          label,
          style: TextStyle(
            color: buttonColor,
            fontSize: 12,
            fontWeight: FontWeight.w400
          )
        )
      )
    ],
  );
}


final informationIcons = Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInformationIcons(Icons.call,color,'CALL'),
        _buildInformationIcons(Icons.near_me,color,'ROUTE'),
        _buildInformationIcons(Icons.share,color,'SHARE')
      ],
    ),
  );
  final textSection = Container(
    padding: EdgeInsets.all(32),
    child: Text(
      'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
      'Alps. Situated 1,578 meters above sea level, it is one of the '
      'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
      'half-hour walk through pastures and pine forest, leads you to the '
      'lake, which warms to 20 degrees Celsius in the summer. Activities '
      'enjoyed here include rowing, and riding the summer toboggan run.',
      softWrap: true,
    ),
  );
  return Container(
      child: ListView(
    children: [
      headerImage,
      titleArea,
      informationIcons,
      textSection,
    ],
  ));
}
