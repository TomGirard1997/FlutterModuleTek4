import 'package:flutter/material.dart';
import 'package:flutter_tek4/pages/new_event/new_event_date.dart';

class NewEventDescription extends StatefulWidget {
  @override
  _NewEventDescriptionState createState() => _NewEventDescriptionState();
}

class _NewEventDescriptionState extends State<NewEventDescription> {

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
            'Event description :',
            style: optionStyle,
          ),
          SizedBox(height: 50),
          TextFormField(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewEventDate()),
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

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
