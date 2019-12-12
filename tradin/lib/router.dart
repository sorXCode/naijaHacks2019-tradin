import 'package:flutter/material.dart';
import 'package:tradin/ui/home/home.dart';
import 'package:tradin/ui/home/searchResult.dart';
import 'package:tradin/ui/user/login.dart';
import 'package:tradin/ui/user/phoneAuth.dart';
import 'package:tradin/ui/user/signup.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Login());
      case 'login':
        return MaterialPageRoute(builder: (_) => Login());
      case 'signup':
        return MaterialPageRoute(builder: (_) => SignUp());
      case 'home':
        return MaterialPageRoute(builder: (_) => Home());
      case 'phoneAuth':
        return MaterialPageRoute(builder: (_) => PhoneAuth());
      case 'searchResults':
        return MaterialPageRoute(builder: (_) => SearchResults());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}