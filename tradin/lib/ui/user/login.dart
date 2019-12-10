import 'package:flutter/material.dart';
import 'package:tradin/ui/user/widgetsConstants.dart';
import 'package:tradin/custom_icons/CustomIcons.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with WidgetsConstants {
  @override
  Widget build(BuildContext context) {
    Widget identity = TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Email/Phone",
        hintStyle: fieldsHintStyle,
        border: OutlineInputBorder(borderRadius: borderRadius),
        prefixIcon: Icon(Icons.perm_identity),
      ),
    );

    Widget password = TextField(
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: "Password",
          hintStyle: fieldsHintStyle,
          border: OutlineInputBorder(borderRadius: borderRadius),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
          )),
    );

    var loginButton = InkWell(
      onTap: () {},
      splashColor: Colors.white,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 40),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: borderRadius, color: Color.fromRGBO(28, 193, 202, 1)),
        child: Text(
          'Login',
        ),
      ),
    );

    var forgotPassword = InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            CustomIcons.help_circled,
            color: Colors.white,
          ),
          Text(
            'FORGOT PASSWORD',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
    var signUpButton = InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.pushNamed(context, 'signup');
      },
      splashColor: Colors.white,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(color: Colors.white)),
        child: Text('CREATE NEW ACCOUNT'),
      ),
    );

    return Material(
      textStyle: TextStyle(
        fontSize: 16,
        fontFamily: "OpenSans",
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorGreen, colorBlue],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(),
                child: Row(
                  children: <Widget>[
                    // TODO: ADD ICON AND lOGIN TEXT HERE
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                margin: fieldsMargin,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('images/logo.png', color: Colors.white,),
                    identity,
                    password,
                    loginButton, // SizedBox(height: 10),
                    forgotPassword,
                    signUpButton,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
