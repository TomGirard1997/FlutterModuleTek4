import 'package:flutter/material.dart';
import 'package:flutter_tek4/pages/new_event/new_event_picture.dart';

class NewEvent extends StatefulWidget {
  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {

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

class HeaderSection extends StatefulWidget {
  const HeaderSection({
    Key? key,
  }) : super(key: key);

  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  late TextEditingController _textController;

  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontFamily: 'Pacifico');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            'Event name :',
            style: optionStyle,
          ),
          SizedBox(height: 50),
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Enter event name',
            ),
          ),
          SizedBox(height: 50),
          SizedBox(
              height: 50,
              width: 50,
              child: RawMaterialButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewEventPicture(name: this._textController.text)),
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
