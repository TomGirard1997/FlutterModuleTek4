import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tek4/models/event.dart';
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

class HeaderSection extends StatefulWidget {
  HeaderSection({Key? key, this.event}) : super(key: key);

  final event;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontFamily: 'Pacifico');

  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  late DBHelper dbEvent;

  List<Picture>? pictures;

  void save(DateTime? date, BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    dbEvent = DBHelper();

    if (date != null) {
      print('confirm $date');
      var eventWithDate = this.widget.event as Event;
      eventWithDate.date = date.toString();
      await dbEvent.addEvent(eventWithDate, this.widget.event.coverPicture);
    } else {
      this.widget.event.date = "";
      await dbEvent.addEvent(this.widget.event, this.widget.event.coverPicture);
    }
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text(
              'Event date :',
              style: HeaderSection.optionStyle,
            ),
            SizedBox(height: 50),
            TextButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2010, 3, 5),
                      maxTime: DateTime(2030, 6, 7), onConfirm: (date) {
                    this.save(date, context);
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Text(
                  "select a date",
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                )),
            SizedBox(height: 50),
            SizedBox(
                height: 50,
                width: 50,
                child: RawMaterialButton(
                  onPressed: () => {save(null, context)},
                  elevation: 2.0,
                  fillColor: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.check,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  padding: EdgeInsets.all(0.0),
                  shape: CircleBorder(),
                )),
          ])),
    );
  }
}
