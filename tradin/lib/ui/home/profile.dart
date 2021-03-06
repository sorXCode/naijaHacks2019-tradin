import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradin/http/authservice.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context, listen: false);
    final _profileDetails = {
      'Name': 'Akinola Grace',
      'Phone': '08110024432',
      'Email': 'Test@usermarket.com',
      'Title': 'Head Tech',
      'Address': '22, AdeKing Road, Ilupeju, Lagos',
      'profile_image': 'images/lady.png',
    };

    return Material(
      color: Colors.grey[200],
      child: FutureBuilder(
        future: _auth.getUserProfile(),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Stack(
                  alignment: Alignment.center,

                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 30),
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                '${_profileDetails['profile_image']}'),
                            radius: 70.0,
                            child: Container(
                                margin: EdgeInsets.only(left: 80, bottom: 5),
                                padding: EdgeInsets.only(),
                                alignment: Alignment.bottomCenter,
                                child: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    print('pick profile picture');
                                  },
                                  iconSize: 30,
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.star,
                                size: 22,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.star,
                                size: 24,
                                color: Colors.grey,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      // alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(16.0, 100, 16.0, 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: ListView.separated(
                        padding: EdgeInsets.only(
                          top: 8.0,
                          bottom: 2.0,
                          right: 10.0,
                          left: 10.0,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Material(
                            color: Colors.white10,
                            child: InkWell(
                              onTap: () => print("IMPLEMENT THIS"),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '${snapshot.data.entries.elementAt(index).key.toUpperCase()}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${snapshot.data.entries.elementAt(index).value}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          height: 40.0,
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
