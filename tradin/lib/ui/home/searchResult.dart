import 'package:flutter/material.dart';

class SearchResults extends StatefulWidget {
  final String query;
  SearchResults({Key key, this.query}) : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
        future: Future.delayed(
            Duration(milliseconds: 1500),
            () => Future.value(
                'No Result Found, we will notify you once we have a result matching your search.')),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.sentiment_dissatisfied, size: 40,),
                Text(
                  snapshot.data,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
