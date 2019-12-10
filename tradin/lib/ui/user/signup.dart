import 'package:flutter/material.dart';
import 'package:tradin/ui/user/widgetsConstants.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with WidgetsConstants {
  @override
  Widget build(BuildContext context) {
    Widget nameField = TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Full Name",
        hintStyle: fieldsHintStyle,
        border: OutlineInputBorder(borderRadius: borderRadius),
        prefixIcon: Icon(Icons.perm_identity),
      ),
      textCapitalization: TextCapitalization.words,
    );

    Widget phoneField = TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Phone Number",
        hintStyle: fieldsHintStyle,
        border: OutlineInputBorder(borderRadius: borderRadius),
        prefixIcon: Icon(Icons.phone),
      ),
      keyboardType: TextInputType.phone,
    );

    Widget emailField = TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        errorStyle: TextStyle(color: Colors.white),
        hintText: "Email Address",
        hintStyle: fieldsHintStyle,
        border: OutlineInputBorder(borderRadius: borderRadius),
        prefixIcon: Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      // textInputAction: TextInputAction.next,
    );

    Widget password = TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Password",
        hintStyle: fieldsHintStyle,
        border: OutlineInputBorder(borderRadius: borderRadius),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye)),
      ),
    );

    Widget workCategory = TextField(
      // onChanged: (val) => signUpState.updateWorkCategory(val),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Work Category",
        hintStyle: fieldsHintStyle,
        border: OutlineInputBorder(borderRadius: borderRadius),
        prefixIcon: Icon(Icons.group_work),
      ),
    );

    Widget occupation = TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Occupation",
        hintStyle: fieldsHintStyle,
        border: OutlineInputBorder(borderRadius: borderRadius),
        prefixIcon: Icon(Icons.work),
      ),
    );

    Widget address = TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Address",
        hintStyle: fieldsHintStyle,
        border: OutlineInputBorder(borderRadius: borderRadius),
        prefixIcon: Icon(Icons.edit_location),
      ),
    );

    Widget signUpButton = InkWell(
      splashColor: Colors.white,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 40),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration:BoxDecoration(
                borderRadius: borderRadius,
                color:Color.fromRGBO(28, 193, 202, 1)
              )
            ,
        child:Text('Register'),
      ),
    );

    Widget termsAndConditions = Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'I agree to the Terms and Conditions of using this application.',
            maxLines: 2,
          ),
        ),
        Checkbox(
          value: true,
          onChanged: (val) {
            setState(
              () {
                
              },
            );
          },
        )
      ],
    );

    Widget _vspace = SizedBox(height: 10);

    // Widget errorMessage = SizedBox(
    //   child: Text(signUpState.errormessage, style: TextStyle(color: Colors.deepOrange),),
    // );
// TODO: USE KEYBOARD AVOIDER FOR FORM RESIZING ON EDIT

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorGreen, colorBlue],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: fieldsMargin,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                nameField,
                _vspace,
                phoneField,
                _vspace,
                emailField,
                _vspace,
                password,
                _vspace,
                termsAndConditions,
                _vspace,
                // errorMessage,
                signUpButton,
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
