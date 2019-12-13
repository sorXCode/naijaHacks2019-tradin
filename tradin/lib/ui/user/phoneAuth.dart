import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradin/http/authservice.dart';
import 'package:tradin/models/phoneAuth.dart';
import 'package:tradin/models/system.dart';
import 'package:tradin/ui/user/widgetsConstants.dart';

class PhoneAuth extends StatefulWidget {
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> with WidgetsConstants {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AuthService>(context, listen: false).requestPhoneVerification();
  }

  @override
  Widget build(BuildContext context) {
    final phoneAuthState = Provider.of<PhoneAuthState>(context);

    Widget buttonBuilder(int number) {
      return InkWell(
        onTap: () => phoneAuthState.updateCode(number.toString()),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            '$number',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w800, color: Colors.greenAccent[900]),
          ),
          radius: 40,
        ),
      );
    }

    var codeBox = Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          alignment: Alignment.center,
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white38,
              width: 10,
            ),
            borderRadius: BorderRadius.circular(10.0),
            
          ),
          child: Text(
            // 'code',
            phoneAuthState.code,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 25,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.backspace,
            color: Color.fromRGBO(105, 250, 174, 1),
          ),
          onPressed: () => phoneAuthState.deleteLast(),
        )
      ],
    );

    var numberPad = Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 40,
              mainAxisSpacing: 40,
              children: List.generate(9, (index) => buttonBuilder(index + 1)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 40,
                mainAxisSpacing: 40,
                children: [
                  SizedBox(),
                  buttonBuilder(0),
                  phoneAuthState.status == Status.idle
                      ? IconButton(
                          icon: Icon(
                            Icons.check,
                            size: 50,
                            color: phoneAuthState.canSubmit
                                ? Colors.blueAccent
                                : Colors.black,
                          ),
                          onPressed: () => phoneAuthState.canSubmit
                              ? phoneAuthState.handleSubmission(context)
                              : null,
                        )
                      : Padding(
                          padding: EdgeInsets.all(15),
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                          )),
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
            SizedBox(
                height: 30,
                child: phoneAuthState.errorMessage == null
                    ? Text('')
                    : Text(
                        '${phoneAuthState.errorMessage}',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
            codeBox,
            numberPad,
          ],
        ),
      ),
    );
  }
}
