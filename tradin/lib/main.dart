import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tradin/http/user.dart';
import 'package:tradin/models/login.dart';
import 'package:tradin/models/signup.dart';
import 'package:tradin/router.dart';
import 'package:tradin/ui/home/home.dart';
import 'package:tradin/ui/user/login.dart';
import 'package:tradin/ui/user/widgetsConstants.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget with WidgetsConstants {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginState()),
        ChangeNotifierProvider(create: (_) => SignUpState()),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
          onGenerateRoute: Router.generateRoute,
          debugShowCheckedModeBanner: false,
          home: Builder(
            builder: (context) =>
                Provider.of<AuthService>(context).userLoggedIn()
                    ? Home()
                    : Login(),
          )),
    );
  }
}