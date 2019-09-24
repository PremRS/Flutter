
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLApp extends StatelessWidget{

  @override
  Widget build (BuildContext context){

    final HttpLink httpLink = HttpLink(uri: 'https://countries.trevorblades.com/' );

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: OptimisticCache(
          dataIdFromObject: typenameDataIdFromObject,
        )
        )
    );
    return GraphQLProvider(
      client: client,
      child:Material(
        child: FirstGql(),
      ),
    );
    
  }
}

class FirstGql extends StatefulWidget{

  const FirstGql({
    Key key,
  }) : super(key: key);

  @override
  FirstGqlState createState() => FirstGqlState();
}
class FirstGqlState extends State<FirstGql> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('GraphQL First Sample'),
      ),
      body: Query(options: QueryOptions(document: r"""
      query getContinents{
        countries {
        name
       }
      }
      """ ),
      builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
        if(result.data == null){
          return Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }
    return ListView.builder(
      itemCount: result.data['countries'].length,
      itemBuilder: (context,i) {
          return ListTile(
            title: Text(result.data['countries'][i]['name']),
        );
      },
    );
  },
      ),
      

      
    );
  }
}