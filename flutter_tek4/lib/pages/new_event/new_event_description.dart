import 'package:flutter/material.dart';
import 'package:flutter_tek4/pages/new_event/new_event_date.dart';
import 'package:flutter_tek4/models/event.dart';

class NewEventDescription extends StatefulWidget {

  NewEventDescription({@required this.event});
  final event;

  @override
  _NewEventDescriptionState createState() => _NewEventDescriptionState(event: event);
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

  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontFamily: 'Pacifico');

  void dispose() {
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            'Event description :',
            style: optionStyle,
          ),
          SizedBox(height: 50),
          TextFormField(
            controller: _textController,
            minLines: 3 , // any number you need (It works as the rows for the textarea)
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Enter your description',
            ),
          ),
          SizedBox(height: 50),
          SizedBox(
              height: 50,
              width: 50,
              child: RawMaterialButton(
                onPressed: () => {
                  print(this.event.title),
                  this.event.description = _textController.text,
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewEventDate(event: this.event)),
                  )
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
