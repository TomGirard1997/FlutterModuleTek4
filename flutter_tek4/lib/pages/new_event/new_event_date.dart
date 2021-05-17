import '../../constants/import.dart';

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
        EventDateScreen(event: this.event),
        SizedBox(height: 40),
      ]),
    );
  }
}

class EventDateScreen extends StatefulWidget {
  EventDateScreen({Key? key, this.event}) : super(key: key);

  final event;

  @override
  _EventDateScreenState createState() => _EventDateScreenState();
}

class _EventDateScreenState extends State<EventDateScreen> {
  late DBHelper dbEvent;

  List<Picture>? pictures;

  void save(DateTime? date, BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    dbEvent = DBHelper();

    if (date != null) {
      var eventWithDate = this.widget.event as Event;
      var day = date.day < 10 ? '0${date.day}' : date.day;
      var month = date.month < 10 ? '0${date.month}' : date.month;
      eventWithDate.date = '$day/$month/${date.year}';
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
              style: CustomStyle.optionStyle(),
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
