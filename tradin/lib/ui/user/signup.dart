import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradin/models/signup.dart';
import 'package:tradin/models/system.dart';
import 'package:tradin/ui/user/widgetsConstants.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with WidgetsConstants {
  @override
  Widget build(BuildContext context) {
    final signUpState = Provider.of<SignUpState>(context, listen: false);
    final signUpButtonEnabled =
        Provider.of<SignUpState>(context, listen: true).activateSignUpButton;

    Widget nameField = TextField(
      onChanged: (val) => signUpState.updateFullName(val),
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
      onChanged: (val) => signUpState.updatePhone(val),
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
      onChanged: (val) => signUpState.updateEmail(val),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        errorText: signUpState.result == Result.failed && signUpState.emailError
            ? signUpState.errormessage
            : null,
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
      onChanged: (val) => signUpState.updatePassword(val),
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: "Password",
          hintStyle: fieldsHintStyle,
          border: OutlineInputBorder(borderRadius: borderRadius),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () => signUpState.togglePasswordVisibility(),
          )),
      obscureText: !signUpState.visiblePassword,
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


    Widget termsAndConditions = Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'I agree to the Terms and Conditions of using this application.',
            maxLines: 2,
          ),
        ),
        Checkbox(
          value: signUpState.agreed,
          onChanged: (val) {
            setState(
              () {
                signUpState.updateAgreed(val);
                if (signUpState.agreed != false) {
                  print('submit button should be active now');
                }
              },
            );
          },
        )
      ],
    );

    Widget signUpButton = InkWell(
      onTap: () => signUpButtonEnabled && signUpState.status == Status.idle
          ? signUpState.userSignUp(context)
          : null,
      splashColor: Colors.white,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 40),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: signUpState.status == Status.idle
            ? BoxDecoration(
                borderRadius: borderRadius,
                color: signUpButtonEnabled
                    ? Color.fromRGBO(28, 193, 202, 1)
                    : Colors.grey,
              )
            : BoxDecoration(),
        child: signUpState.status == Status.busy
            ? CircularProgressIndicator()
            : Text('Register'),
      ),
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
                    // TODO: separate reset to dispose method
                    signUpState.reset();
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