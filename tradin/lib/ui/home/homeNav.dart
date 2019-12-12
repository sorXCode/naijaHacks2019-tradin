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
    final enteries = [
      {
        "title": "Need A Surveyor",
        "description":
            """We know you can’t build a completely enabled feature for your solution but ensure features like authentication (login/signup/logout) etc are available to test with.Implementation still continues till""",
        "category": "Building/Land",
        "location": "Onikan, Lagos State",
        "budget": "200,000",
        "updated_when": "20 minutes ago"
      },
      {
        "title": "Need A Surveyor",
        "description":
            """We know you can’t build a completely enabled feature for your solution but ensure features like authentication (login/signup/logout) etc are available to test with.Implementation still continues till""",
        "category": "Building/Land",
        "location": "Onikan, Lagos State",
        "budget": "200,000",
        "updated_when": "20 minutes ago"
      },
      {
        "title": "Need A Surveyor",
        "description":
            """We know you can’t build a completely enabled feature for your solution but ensure features like authentication (login/signup/logout) etc are available to test with.Implementation still continues till""",
        "category": "Building/Land",
        "location": "Onikan, Lagos State",
        "budget": "200,000",
        "updated_when": "20 minutes ago"
      },
      {
        "title": "Need A Surveyor",
        "description":
            """We know you can’t build a completely enabled feature for your solution but ensure features like authentication (login/signup/logout) etc are available to test with.Implementation still continues till""",
        "category": "Building/Land",
        "location": "Onikan, Lagos State",
        "budget": "200,000",
        "updated_when": "20 minutes ago"
      },
      {
        "title": "Need A Surveyor",
        "description":
            """We know you can’t build a completely enabled feature for your solution but ensure features like authentication (login/signup/logout) etc are available to test with.Implementation still continues till""",
        "category": "Building/Land",
        "location": "Onikan, Lagos State",
        "budget": "200,000",
        "updated_when": "20 minutes ago"
      },
      {
        "title": "Need A Surveyor",
        "description":
            """We know you can’t build a completely enabled feature for your solution but ensure features like authentication (login/signup/logout) etc are available to test with.Implementation still continues till""",
        "category": "Building/Land",
        "location": "Onikan, Lagos State",
        "budget": "200,000",
        "updated_when": "20 minutes ago"
      },
      {
        "title": "Need A Surveyor",
        "description":
            """We know you can’t build a completely enabled feature for your solution but ensure features like authentication (login/signup/logout) etc are available to test with.Implementation still continues till""",
        "category": "Building/Land",
        "location": "Onikan, Lagos State",
        "budget": "200,000",
        "updated_when": "20 minutes ago"
      },
      {
        "title": "Need A Surveyor",
        "description":
            """We know you can’t build a completely enabled feature for your solution but ensure features like authentication (login/signup/logout) etc are available to test with.Implementation still continues till""",
        "category": "Building/Land",
        "location": "Onikan, Lagos State",
        "budget": "200,000",
        "updated_when": "20 minutes ago"
      },
      {
        "title": "Need A Surveyor",
        "description":
            """We know you can’t build a completely enabled feature for your solution but ensure features like authentication (login/signup/logout) etc are available to test with.Implementation still continues till""",
        "category": "Building/Land",
        "location": "Onikan, Lagos State",
        "budget": "200,000",
        "updated_when": "20 minutes ago"
      },
    ];

    var feedenteries = enteries.map((entry) => Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                entry['title'],
                maxLines: 1,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                entry['description'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.category, color: Colors.blue),
                      Text(
                        entry['category'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.blue),
                      Text(entry['location']),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.access_time, color: Colors.blue),
                      Text(entry['updated_when']),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.payment, color: Colors.blue),
                      Text("\#${entry['budget']}"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
    return Scaffold(
      body: Stack(
        children: <Widget>[
          searchBox(),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 100, 10.0, 50),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ...feedenteries,
                ],
              ),
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter, child: postRequestButton),
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
