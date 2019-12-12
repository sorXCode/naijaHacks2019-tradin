import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget searchBox() {
      TextEditingController searchController = TextEditingController();
      return Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 10.0, right: 12.0, left: 12.0),
        child: TextField(
          maxLines: 1,
          controller: searchController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                searchController.text.isNotEmpty
                    ? Navigator.pushNamed(context, 'searchResults',
                        arguments: searchBox())
                    : null;
              },
            ),
            labelText: 'Search',
          ),
        ),
      );
    }

    final postRequestButton = MaterialButton(
      onPressed: () {},
      color: Colors.greenAccent,
      child: Text("POST REQUEST",
          softWrap: true,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          searchBox(),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 100, 10.0, 50),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ...List.generate(100,
                      (int x) => listItem(Colors.blueAccent, "sjkdlkskdlks")),
                ],
              ),
            ),
          ),
          Container(alignment: Alignment.bottomCenter, child: postRequestButton),
        ],
      ),
    );
  }

  Widget listItem(Color color, String title) => Container(
        height: 100.0,
        color: color,
        child: Center(
          child: Text(
            "$title",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
