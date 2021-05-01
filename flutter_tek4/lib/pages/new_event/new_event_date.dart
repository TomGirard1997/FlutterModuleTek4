import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NewEventDate extends StatefulWidget {
  @override
  _NewEventDateState createState() => _NewEventDateState();
}

class _NewEventDateState extends State<NewEventDate> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memories Book'),
        centerTitle: true,
      ),
      body: ListView(children: <Widget>[
        SizedBox(height: 100),
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
      fontSize: 30, fontFamily: 'Pacifico');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            'Event date :',
            style: optionStyle,
          ),
          SizedBox(height: 50),
          TextButton(
            onPressed: () {
                DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2015, 3, 5),
                                      maxTime: DateTime(2022, 6, 7), onChanged: (date) {
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    print('confirm $date');
                                  }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
            child: Text(
                'show date time picker',
                style: TextStyle(color: Colors.blue),
            )),
          SizedBox(height: 50),
          SizedBox(
              height: 50,
              width: 50,
              child: RawMaterialButton(
                onPressed: () => {
                },
                elevation: 2.0,
                fillColor: Colors.white,
                child: Icon(
                  Icons.check,
                  size: 30.0,
                ),
                padding: EdgeInsets.all(0.0),
                shape: CircleBorder(),
              )),
        ])
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
