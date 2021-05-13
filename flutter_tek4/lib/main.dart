// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_tek4/pages/user_profile.dart';
import 'package:flutter_tek4/pages/settings_page.dart';
import 'package:flutter_tek4/pages/home.dart';
import 'package:flutter_tek4/services/config.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:english_words/english_words.dart';

void main() async {
  await Hive.initFlutter();
  box = await Hive.openBox('myTheme');
  runApp(MyApp());
} 

class MyApp extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<MyApp>{
  // const MyApp({Key? key}) : super(key: key);

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      print('changes');
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memories Book',
      theme: ThemeData(
          brightness: Brightness.light,
            fontFamily: "Pacifico",
            primaryColor: const Color(0xFF13172a),
            accentColor: const Color(0xFFFFC117),),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
            fontFamily: "Pacifico",
            primaryColor: const Color(0xFF13172a),
            accentColor: const Color(0xFFFFFFFF),),
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
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Pacifico');
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    UserProfile(),
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
