import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradin/custom_icons/CustomIcons.dart';
import 'package:tradin/models/login.dart';
import 'package:tradin/models/system.dart';
import 'package:tradin/http/authservice.dart';
import 'package:tradin/ui/user/widgetsConstants.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with WidgetsConstants {

  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context, listen: false);
    final loginButtonEnabled =
        Provider.of<LoginState>(context).activateLoginButton;

    Widget identity = TextField(
      onChanged: (val) => loginState.updateIdentity(val),
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
      onChanged: (val) => loginState.updatePassword(val),
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: "Password",
          hintStyle: fieldsHintStyle,
          border: OutlineInputBorder(borderRadius: borderRadius),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () => loginState.togglePasswordVisibility(),
          )),
      obscureText: !loginState.visiblePassword,
    );

    var loginButton = InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        return loginButtonEnabled && loginState.status == Status.idle
            ? loginState.handleLogin(context)
            : null;
      },
      splashColor: Colors.white,
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 40),
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: loginState.status == Status.idle
              ? BoxDecoration(
                  borderRadius: borderRadius,
                  color: loginButtonEnabled
                      ? loginState.result == Result.failed
                          ? Colors.grey
                          : Color.fromRGBO(28, 193, 202, 1)
                      : Colors.grey,
                )
              : BoxDecoration(),
          child: loginState.status == Status.busy
              ? CircularProgressIndicator()
              : Text(
                  loginState.result == Result.failed
                      ? loginState.erroressage
                      : 'Login',
                )),
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