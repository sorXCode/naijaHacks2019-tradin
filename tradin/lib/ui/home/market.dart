import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> categories = [
    {
      'title': 'Art',
      'icon': 'images/icons/art.png',
    },
    {
      'title': 'Beauty',
      'icon': 'images/icons/beauty.png',
    },
    {
      'title': 'Building',
      'icon': 'images/icons/building.png',
    },
    {
      'title': 'Clothing',
      'icon': 'images/icons/clothing.png',
    },
    {
      'title': 'Food',
      'icon': 'images/icons/food.png',
    },
    {
      'title': 'General Sales',
      'icon': 'images/icons/art.png',
    },
    {
      'title': 'I.C.T.',
      'icon': 'images/icons/IT.png',
    },
    {
      'title': 'Rentals',
      'icon': 'images/icons/rentals.png',
    },
    {
      'title': 'Repairs',
      'icon': 'images/icons/repair.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    var _gridViewEntries = categories.map((item) => Container(
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.all(8.0),
          child: Material(
            // highlightColor: Colors.grey,
            color: Colors.white,
            child: InkWell(
              onTap: () => print("${item['title']} tapped"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    item['icon'],
                    fit: BoxFit.cover,
                  ),
                  Text(
                    item['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ));

    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 10.0, right: 12.0, left: 12.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () =>
                        print("searching ${searchController.text}"),
                  ),
                  labelText: 'Search',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.count(
                primary: false,
                crossAxisCount: 3,
                childAspectRatio: 0.9,
                padding: EdgeInsets.all(5.0),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: <Widget>[
                  ..._gridViewEntries,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}