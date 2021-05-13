import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_tek4/appdata/appdata.dart';
import 'package:flutter_tek4/services/config.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late Settings setting;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
                currentTheme.switchTheme();
            },
            label: Text('Switch Theme'),
            icon: Icon(Icons.brightness_high),
            ),  
        body: Center(
          
            child: Column(children: <Widget>[
            SizedBox(height: 15),
            InkWell(
              child: Text('Change language', 
              style: TextStyle(
                fontSize: 20
              )),
              onTap: () {print("skuuurt");},
            ),
            SizedBox(height: 15),
            InkWell(
              child: Text('Find out more about MemoriesBook',
              style: TextStyle(
                fontSize: 20
              )),
              onTap: () {print("pull uuuuup");}
            ),
            SizedBox(height: 15),
            InkWell(
              child: Text('Help',style: TextStyle(
                fontSize: 20
              )),
              onTap: () {print("big uuuuup");}
            ),
            
    ])));
  }
}
