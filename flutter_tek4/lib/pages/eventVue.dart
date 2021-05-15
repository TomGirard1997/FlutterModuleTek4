import 'package:flutter/material.dart';
import 'package:flutter_tek4/pages/new_event/new_event_date.dart';
import 'package:flutter_tek4/models/event.dart';

class EventVue extends StatefulWidget {

  EventVue({@required this.event});
  final event;

  @override
  _EventVueState createState() => _EventVueState(event: event);
}

class _EventVueState extends State<EventVue> {

  _EventVueState({@required this.event});
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
        HeaderSection(event: event),
        SizedBox(height: 40),
      ]),
    );
  }
}

class HeaderSection extends StatelessWidget {

  HeaderSection({required this.event});

  final Event event;
  late final TextEditingController _textController = TextEditingController();

  static const TextStyle titleStyle = TextStyle(
      fontSize: 35, fontFamily: 'Pacifico');

  static const TextStyle descriptionStyle = TextStyle(
      fontSize: 20, fontFamily: 'Pacifico');

  void dispose() {
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            event.title,
            style: titleStyle,
          ),
          SizedBox(height: 20),
          Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: Image.memory(event.coverPicture!.data!).image,
                      fit: BoxFit.cover))),
          SizedBox(height: 50),
          Text(
            event.description,
            style: descriptionStyle,
          ),
        ])
      ),
    );
  }
}
