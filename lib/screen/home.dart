import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

int _page = 0;
GlobalKey _bottomNavigationKey = GlobalKey();

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      drawer: _drawerMenu(context),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.blueAccent[400],
          ),
          Icon(Icons.list, size: 30, color: Colors.blueAccent[400]),
          Icon(Icons.compare_arrows, size: 30, color: Colors.blueAccent[400]),
          Icon(Icons.map_rounded, size: 30, color: Colors.blueAccent[400]),
          Icon(Icons.perm_identity, size: 30, color: Colors.blueAccent[400]),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent[200],
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
            if (_page == 0) {
              print("asd");
            } else if (_page == 1) {
              print("asd");
            } else if (_page == 2) {
            } else if (_page == 3) {
            } else {}
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }

  bool isSwitched = false;
  ThemeData _light = ThemeData.light().copyWith(
    primaryColor: Colors.green,
  );
  ThemeData _dark = ThemeData.dark().copyWith(
    primaryColor: Colors.blueGrey,
  );
  Widget _drawerMenu(context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Vatanak Sambath"),
            accountEmail: Text("sambathvatanak@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
                "VS",
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, size: 26, color: Colors.blueAccent[400]),
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:
                Icon(Icons.settings, size: 26, color: Colors.blueAccent[400]),
            title: Text("Settings"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts_rounded,
                size: 26, color: Colors.blueAccent[400]),
            title: Text("About"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Container(
              margin: EdgeInsets.only(left: 18),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.wb_sunny,
                    size: 26,
                    color: Colors.blueAccent[200],
                  ),
                  SizedBox(
                    width: 23,
                  ),
                  Text(
                    'Dark Mode',
                    //style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        isSwitched ? print(isSwitched) : print(isSwitched);
                      });
                    },
                    activeTrackColor: Colors.blueAccent[200],
                    activeColor: Colors.grey[50],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

// SwitchListTile(
//               title: Text('Dark Mode'),
//               value: darkTheme,
//               onChanged: (bool value) {
//                 setState(() {
//                   darkTheme = value;
//                 });
//               },
//             ),
