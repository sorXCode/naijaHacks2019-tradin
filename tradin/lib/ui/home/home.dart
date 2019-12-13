import 'package:flutter/material.dart';
import 'package:tradin/ui/home/homeNav.dart';
import 'package:tradin/ui/home/market.dart';
import 'package:tradin/ui/home/messages.dart';
import 'package:tradin/ui/home/profile.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _tabPages = <Widget>[
      ..._bottomNavigationBarItems.map(
        (item) => item['activity'],
      )
    ];
    final _buttomNavBarItems = <BottomNavigationBarItem>[
      ..._bottomNavigationBarItems.map((item) => BottomNavigationBarItem(
          title: Text(item['title']),
          activeIcon: Image(
            image: AssetImage(item['icon']),
            color: Colors.blue,
          ),
          icon: Image(
            image: AssetImage(item['icon']),
          )))
    ];

    final bottomNavBar = BottomNavigationBar(
      items: _buttomNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.grey[200],
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      iconSize: 30,
    );

    return Scaffold(
      floatingActionButton: _currentTabIndex == 3
          ? IconButton(
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.black54,
                size: 40,
              ),
              onPressed: () {},
            )
            : null,
      body: _tabPages[_currentTabIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}

var _bottomNavigationBarItems = [
  {
    'title': 'Feeds',
    'icon': 'images/icons/home.png',
    'activity': HomePage(),
  },
  {
    'title': 'Market',
    'icon': 'images/icons/market.png',
    'activity': Market(),
  },
  {
    'title': 'Messages',
    'icon': 'images/icons/messages.png',
    'activity': Messages(),
  },
  {
    'title': 'Profile',
    'icon': 'images/icons/profile.png',
    'activity': Profile(),
  },
];
