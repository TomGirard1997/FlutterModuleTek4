import '../constants/import.dart';

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
        EventListSection(),
      ]),
    );
  }
}

class AddEventButton extends StatelessWidget {
  final AsyncCallback updateEvent;

  AddEventButton({required this.updateEvent});

  createEvent(context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewEvent()),
    );
    await updateEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            SizedBox(
                height: 50,
                width: 50,
                child: RawMaterialButton(
                  onPressed: () => {createEvent(context)},
                  elevation: 2.0,
                  fillColor: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  padding: EdgeInsets.all(5.0),
                  shape: CircleBorder(),
                )),
          ])),
    );
  }
}

class EventListSection extends StatefulWidget {
  @override
  _EventListSectionState createState() => _EventListSectionState();
}

class _EventListSectionState extends State<EventListSection> {
  DBHelper dbClient = DBHelper();

  List<Event>? events;

  @override
  initState() {
    super.initState();
    _initDatas();
    Future.delayed(
        Duration.zero,
        () => Loader.show(
              context,
              isBottomBarOverlay: false,
              progressIndicator: CircularProgressIndicator(),
              themeData:
                  Theme.of(context).copyWith(accentColor: Colors.amber[800]),
              overlayColor: Colors.transparent,
            ));

    Future.delayed(Duration(seconds: 5), () => Loader.hide());
  }

  Future _initDatas() async {
    var futureEvent = await dbClient.getAllEvents();
    setState(() {
      events = futureEvent;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (events != null) {
      return SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(children: <Widget>[
            SizedBox(height: 20),
            Text("My Albums",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.amber[800],
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                )),
            SizedBox(height: 60),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: events!.length,
              itemBuilder: (context, int index) {
                return EventItemSection(event: events![index], index: index);
              },
            ),
            AddEventButton(updateEvent: _initDatas),
            SizedBox(height: 40),
          ]));
    } else {
      return Container();
    }
  }
}

class EventItemSection extends StatelessWidget {
  EventItemSection({required this.event, required this.index});

  final Event event;
  final int index;

  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Pacifico');

  @override
  Widget build(BuildContext context) {
    if (index % 2 == 0) {
      return Container(
          child: Column(
        children: [
          EventItemRightOriented(event: event),
          SizedBox(height: 50),
          const Divider(
            height: 10,
            thickness: 3,
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(height: 50),
        ],
      ));
    } else {
      return Container(
          child: Column(children: [
        EventItemLeftOriented(event: event),
        SizedBox(height: 50),
        const Divider(
          height: 10,
          thickness: 3,
          indent: 20,
          endIndent: 20,
        ),
        SizedBox(height: 50)
      ]));
    }
  }
}

class EventItemRightOriented extends StatelessWidget {
  const EventItemRightOriented({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: Image.memory(event.coverPicture!.data!).image,
                      fit: BoxFit.cover))),
          Flexible(
              child: TextButton(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventVue(event: event)),
                        )
                      },
                  child: Text(
                    event.title,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ))),
        ]);
  }
}

class EventItemLeftOriented extends StatelessWidget {
  const EventItemLeftOriented({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
              child: TextButton(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventVue(event: event)),
                        )
                      },
                  child: Text(
                    event.title,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Theme.of(context).accentColor,
                    ),
                  ))),
          Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: Image.memory(event.coverPicture!.data!).image,
                      fit: BoxFit.cover))),
        ]);
  }
}
