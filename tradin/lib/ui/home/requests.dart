import 'package:flutter/material.dart';

class PostRequest extends StatefulWidget {
  @override
  _PostRequestState createState() => _PostRequestState();
}

class _PostRequestState extends State<PostRequest> {
  bool includeLocality = false;

  bool includeGlobal = false;

  bool includeMyLocation = false;

  @override
  Widget build(BuildContext context) {
    final requestCoverage = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Request coverage',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                value: includeLocality,
                onChanged: (val) {
                  setState(() {
                    includeLocality = !includeLocality;
                  });
                },
              ),
              Text("My Locality"),
            ],
          ),
        ),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Checkbox(
                value: includeGlobal,
                onChanged: (val) {
                  setState(() {
                    includeGlobal = !includeGlobal;
                  });
                },
              ),
              Text("Global"),
            ],
          ),
        ),
      ],
    );

    final includeLocation = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: includeMyLocation,
          onChanged: (val) {
            setState(() {
              includeMyLocation = !includeMyLocation;
            });
          },
        ),
        Text("Include my location in request"),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Make Request"),
        backgroundColor: Colors.greenAccent[200],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                labelText: "Description",
                hintText: "Add brief description of your request",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 200,
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Budget",
                  prefixIcon: Text(
                    "#",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            requestCoverage,
            SizedBox(
              height: 10,
            ),
            includeLocation,
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Request Submitted"),
                  backgroundColor: Colors.blue,
                ));
              },
              color: Colors.greenAccent,
              child: Text("POST"),
            )
          ],
        ),
      ),
    );
  }
}
