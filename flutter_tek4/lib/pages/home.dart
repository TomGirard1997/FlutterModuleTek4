import 'package:flutter/material.dart';
import 'package:flutter_tek4/pages/new_event/new_event.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        SizedBox(height: 20),
        HeaderSection(),
        SizedBox(height: 40),
      ]),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    Key? key,
  }) : super(key: key);

  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Pacifico');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        SizedBox(
              height: 50,
              width: 50,
              child: RawMaterialButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewEvent()),
                  )
                },
                elevation: 2.0,
                fillColor: Colors.white,
                child: Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 30.0,
                ),
                padding: EdgeInsets.all(5.0),
                shape: CircleBorder(),
              )),
        ])
      ),
    );
  }
}
