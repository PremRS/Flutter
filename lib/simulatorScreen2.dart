import 'package:flutter/material.dart';

class MyScreenTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromRGBO(233, 50, 90, 1),
              Color.fromRGBO(245, 68, 85, 1),
              Color.fromRGBO(253, 79, 83, 1),
              Color.fromRGBO(254, 81, 82, 1),
             
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            stops: [0.1, 0.3, 0.5, 0.8]),
      ),
      child: Column(children: [
        appBar(context),

        Expanded(
          child:ListView.builder(
          itemCount: 4,
          itemBuilder: (context,i){
            return new BlogBody();
          },
        )
        )
     
        

      ]),
    ));
  }
}

Widget appBar(BuildContext context) => Container(
      padding: const EdgeInsets.fromLTRB(8,24,8,0),
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
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ],
      ),
    );

Widget picture() => Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
          elevation: 24,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(children: [
            Expanded(
                child: ClipRRect(
              child: Image.asset(
                'assets/lake.jpg',
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ))
          ])),
    );

Widget pictureTitle() => Row(
      children: [
        Expanded(
            child: Container(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                child: Text(
                  'Swiss Lake Ground',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromRGBO(233, 50, 90, 1),
                    fontWeight: FontWeight.w600,
                  ),
                )))
      ],
    );

Widget authorAndDate() => Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              'Prem Rajasekaran',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Column(children: [
          Text(
            'Jul 20',
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ]),
      ],
    ));

Widget selectionButtons() => Row(
      children: [
        Expanded(
          child: Container(
              padding: EdgeInsets.fromLTRB(20, 16, 12, 16),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.message,
                      color: Colors.grey,
                    ),
                    Text(
                      '26.2k Comments',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Icon(
                      Icons.thumb_up,
                      color: Color.fromRGBO(233, 50, 90, 1),
                    ),
                    Text(
                      '12.5k Likes',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(233, 50, 90, 1),
                      ),
                    ),
                    Icon(
                      Icons.share,
                      color: Colors.grey,
                    ),
                    Text(
                      '12k Shares',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ])),
        )
      ],
    );

class BlogBody extends StatefulWidget {
  @override
  _BlogBodyState createState() => _BlogBodyState();
}

class _BlogBodyState extends State<BlogBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Stack(children: [
      picture(),
      Positioned(
          top: 143,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: 387,
              height: 140,
              child: Card(
                  elevation: 24,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      pictureTitle(),
                      authorAndDate(),
                      selectionButtons()
                    ],
                  )))),
    ]),
    );
    
  }
}
