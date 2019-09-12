
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Generator')
      ),
      body: RandomWords(),
      
    );
  }
  
}

class RandomWords extends StatefulWidget {
  
  @override
  _RandomWordsState createState() => _RandomWordsState();
    
  }
  
  class _RandomWordsState extends State<RandomWords> {
  
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: _listSuggestions(),
    );
  }

  Widget _listSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if(i.isOdd) return Divider();

        final _index =  i ~/ 2;
        if(_index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[_index]);
      });
  }

  Widget _buildRow(WordPair words) {
    return ListTile(
      title: Text(
        words.asPascalCase,
        style: _biggerFont
      ),
    );
  }

}