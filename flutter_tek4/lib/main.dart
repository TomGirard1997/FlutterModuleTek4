// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'constants/import.dart';

void main() async {
  await Hive.initFlutter();
  box = await Hive.openBox('myTheme');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<MyApp> {
  // const MyApp({Key? key}) : super(key: key);

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memories Book',
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: "Pacifico",
        primaryColor: Color(0xFF13172a),
        accentColor: Color(0xFFFFC117),
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: "Pacifico",
          primaryColor: Color(0xFF13172a),
          accentColor: Color(0xFFFFFFFF),
          canvasColor: Colors.black87),
      themeMode: currentTheme.currentTheme(),
      home: MyStatefulWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    UserProfile(),
    MapSample(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memories Book'),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.perm_identity),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.public),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: currentTheme.currentTheme() == ThemeMode.dark
            ? Theme.of(context).accentColor
            : Color(0xFFFFFFFF),
        unselectedLabelStyle: TextStyle(color: Theme.of(context).accentColor),
        showUnselectedLabels: true,
        elevation: 2,
        onTap: _onItemTapped,
      ),
    );
  }
}
