
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GraphQLIndex extends StatelessWidget {

  @override
  Widget build(BuildContext context){

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('GraphQL Index'),
        ),
        body:Center(
          child: Column(
            children: <Widget>[
               buildListTile(context, 'GraphQL First Sample', '/gqlApp'),
               buildListTile(context, 'GraphQL Image Upload', '/gqlUpload'),
               buildListTile(context, 'GraphQL File Upload', '/gqlFile')
            ],
          )
        ) ,
      ),
    );
  }
}

buildListTile(BuildContext context, String title, String route) => 
                ListTile(
                        title: Text(title),
                        onTap: ()=> Navigator.pushNamed(context, route),
                        );