import 'package:flutter/material.dart';
import 'package:flutter_tek4/pages/new_event/new_event.dart';
import 'package:flutter_tek4/pages/eventVue.dart';
import 'package:flutter_tek4/controllers/dbHelper.dart';
import 'package:flutter_tek4/models/event.dart';

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
        EventListSection(),
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

class EventListSection extends StatefulWidget {

  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Pacifico');

  @override
  _EventListSectionState createState() => _EventListSectionState();
}

class _EventListSectionState extends State<EventListSection> {
  DBHelper dbClient = DBHelper();

  List<Event>? events;

  @override
  initState() {
    super.initState();

    initDatas();
  }

  Future initDatas() async {
    var futureEvent = await dbClient.getAllEvents();

    setState(() {
      events = futureEvent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: events!.length,
              itemBuilder: (context, int index) {
                return EventItemSection(event: events![index]);
              },
            ),
    );
  }
}

class EventItemSection extends StatelessWidget {
  
  EventItemSection({required this.event});

  final Event event;

  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Pacifico');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
      children: <Widget>[
        SizedBox(width: 50),
        Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: Image.memory(event.coverPicture!.data!).image,
                      fit: BoxFit.cover))),
        SizedBox(width: 50),
        TextButton(
            onPressed: () => {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventVue(event: event)),
              )
            },
            child: Text(
            event.title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        )),
        SizedBox(height: 90),
      ]
      )
    );
  }
}
