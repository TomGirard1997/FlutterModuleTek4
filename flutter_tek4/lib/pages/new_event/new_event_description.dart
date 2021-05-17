import 'package:flutter/material.dart';
import 'package:flutter_tek4/models/event.dart';
import 'package:flutter_tek4/pages/new_event/new_event_geopos.dart';
import 'package:flutter_tek4/utils/iconUtils.dart';

class NewEventDescription extends StatefulWidget {
  NewEventDescription({@required this.event});
  final event;

  @override
  _NewEventDescriptionState createState() =>
      _NewEventDescriptionState(event: event);
}

class _NewEventDescriptionState extends State<NewEventDescription> {
  _NewEventDescriptionState({@required this.event});
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

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontFamily: 'Pacifico');

  void dispose() {
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text(
              'Event description :',
              style: optionStyle,
            ),
            SizedBox(height: 50),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextFormField(
                controller: _textController,
                minLines:
                    null, // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Enter your description',
                ),
              ),
            ),
            SizedBox(height: 50),
            CheckIconEventDescr(event: event, textController: _textController),
          ])),
    );
  }
}
