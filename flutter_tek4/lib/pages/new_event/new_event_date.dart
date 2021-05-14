import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tek4/models/event.dart';
import 'package:flutter_tek4/pages/home.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_tek4/controllers/dbHelper.dart';

class NewEventDate extends StatefulWidget {
  NewEventDate({@required this.event});
  final event;

  @override
  _NewEventDateState createState() => _NewEventDateState(event: this.event);
}

class _NewEventDateState extends State<NewEventDate> {

  _NewEventDateState({@required this.event});
  final event;

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
        HeaderSection(event: this.event),
        SizedBox(height: 40),
      ]),
    );
  }
}

class HeaderSection extends StatelessWidget {
  HeaderSection({
    Key? key, this.event
  }) : super(key: key);

  final event;
  late DBHelper dbEvent;
  List<Picture>? pictures;

  late final TextEditingController _dateController = TextEditingController();

  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontFamily: 'Pacifico');

  void save (DateTime date, BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    dbEvent = DBHelper();

    print('confirm $date');
    var eventWithDate = this.event as Event;
    eventWithDate.date = date.toString();
    await dbEvent.addEvent(eventWithDate, this.event.coverPicture);
    MaterialPageRoute(builder: (context) => Home());
  }

  void dispose() {
    _dateController.dispose();
  }

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
                                      minTime: DateTime(2018, 3, 5),
                                      maxTime: DateTime(2022, 6, 7), 
                                      onConfirm: (date) {
                                        this.save(date, context);
                                      }, 
                                      currentTime: DateTime.now(), locale: LocaleType.en);
            },
            child: Text(
                "select a date",
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
}
