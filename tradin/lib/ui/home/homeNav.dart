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

    Widget listItem(Map<String, dynamic> entry) => InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(entry['title']),
                      content: Text(
                        entry['description'],
                        textAlign: TextAlign.justify,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Cancel', style: TextStyle(color: Colors.black),),
                          onPressed: () => Navigator.pop(context, 'cancel'),
                        ),
                        FlatButton(
                          child: Text('Submit Proposal'),
                          onPressed: () =>
                              Navigator.pop(context, 'submit proposal'),
                        )
                      ],
                    )).then((val) {
              if (val != null && val != 'cancel') {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Your verification status is incomplete, update your details and try later..'),
                  backgroundColor: Colors.blue,
                  duration: Duration(milliseconds: 2500),
                ));
              }
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
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
          ),
        );
    var feedenteries = enteries.map((entry) => listItem(entry));
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
}
