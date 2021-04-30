import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_tek4/appdata/appdata.dart';

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
    bool isSwitched = false;
    return Scaffold(
        body: Center(
            child: Column(children: <Widget>[
            SizedBox(height: 30),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 56),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Text('Dark Mode'),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    print(isSwitched);
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ])),
            SizedBox(height: 15),
            InkWell(
              child: Text('Find out more about MemoriesBook'),
              onTap: () {print("skuuurt");},
            ),
            SizedBox(height: 15),
            InkWell(
              child: Text('Rules and legals notice'),
              onTap: () {print("pull uuuuup");}
            ),
            SizedBox(height: 15),
            InkWell(
              child: Text('Help'),
              onTap: () {print("big uuuuup");}
            ),
    ])));
  }
}
