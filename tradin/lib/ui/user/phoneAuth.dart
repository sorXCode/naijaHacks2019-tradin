import 'package:flutter/material.dart';
import 'package:tradin/ui/user/widgetsConstants.dart';

class PhoneAuth extends StatefulWidget {
  PhoneAuth({Key key}) : super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> with WidgetsConstants {
  @override
  Widget build(BuildContext context) {
    var codeBox = Container(
      alignment: Alignment.center,
      width: 250,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.white38, width: 8)),
      child: Text(
        "1892",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: 25,
        ),
      ),
    );

    var numberPad = Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 40,
              mainAxisSpacing: 40,
              children: List.generate(9, (number) => buttonBuilder(number + 1)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 40,
                mainAxisSpacing: 40,
                children: [
                  SizedBox(),
                  buttonBuilder(0),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 40,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorGreen, colorBlue],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            codeBox,
            numberPad,
          ],
        ),
      ),
    );
  }

  Widget buttonBuilder(int number) {
    return CircleAvatar(
      backgroundColor: Colors.greenAccent,
      child: Text(
        '$number',
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white),
      ),
      radius: 40,
    );
  }
}
