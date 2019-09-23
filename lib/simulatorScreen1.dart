import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class MyScreenOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          appBar(context),
          Expanded(
              child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, i) {
              return new MyBody();
            },
          ))
        ],
      ),
    );
  }
}

Widget appBar(BuildContext context) => Container(
    decoration: BoxDecoration(color: Colors.blue),
    padding: const EdgeInsets.fromLTRB(0, 30, 20, 0),
    child: Row(
      children: [
        IconButton(
            icon: Icon(
              Icons.navigate_before,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        Expanded(
          child: Container(
              child: Text('Home Page',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ))),
        ),
        Badge(
          badgeContent: Text(
            '5',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          badgeColor: Colors.red,
          child: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ),
      ],
    ));

class MyBody extends StatefulWidget {

  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  final Set<BuildContext> _navigation = Set<BuildContext>();
  bool quantity = true;
  bool cart = false;
  int counter = 1;

  productImage() => Container(
      // decoration:BoxDecoration(border: Border.all(color: Colors.black)),
      padding: EdgeInsets.all(4),
      child: Image.asset(
        'assets/lake.jpg',
        fit: BoxFit.cover,
      ));

  productDescription() => Container(
      // decoration:BoxDecoration(border: Border.all(color: Colors.black)),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // padding: const EdgeInsets.only(bottom: 8),
          Text('Item 1',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text('In Stock',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ))),
          Row(
            children: [
              Text(
                'Rs. 234',
                style: TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Text(' Rs. 190')
            ],
          )
        ],
      ));

  productToCart(BuildContext context, bool state) => RaisedButton(
      onPressed: () {
        setState(() {
          if (!state) {
            _navigation.add(context);
            quantity = false;
            cart = true;
          }
        });
      },
      child: Text(
        'Add to cart',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      color: Colors.blue);

  productQuantity(BuildContext context, bool _state) {
    
    return Row(
      children: [
        Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  counter++;
                  print(counter);
                });
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
              tooltip: 'Add',
            )),
        Expanded(
            child: Text(
          '$counter',
          textAlign: TextAlign.center,
        )),
        Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  counter--;
                  if (_state && (counter == 0)) {
                    quantity = true;
                    cart = false;
                    counter++;
                    _navigation.remove(context);
                  }
                  
                });
              },
              icon: Icon(
                Icons.remove,
                color: Colors.white,
                size: 20,
              ),
              tooltip: 'Remove',
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _already = _navigation.contains(context);
    return Container(
        height: 100,
        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
        // color: Colors.red,
        child: Card(
          child: Row(children: [
            productImage(),
            productDescription(),
            Expanded(
                child: Container(
                    // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    padding: const EdgeInsets.all(16),
                    child: Stack(
                      children: [
                        Offstage(
                          child: productQuantity(context, _already),
                          offstage: quantity,
                        ),
                        Offstage(
                          child: productToCart(context, _already),
                          offstage: cart,
                        ),

                        // Opacity(
                        //   opacity: 1,

                        //   child: productQuantity(context) ,
                        //   ),
                        // Opacity(
                        //   opacity: 0 ,
                        //   child: productToCart(context, _already) ,
                        //   ),
                      ],
                    )))
          ]),
          elevation: 2,
          // color: Colors.green,
        ));
  }
}

//   _navigation.remove(context);
//   opQ = 0;
//   op = 1;
