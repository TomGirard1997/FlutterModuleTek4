import 'package:flutter/material.dart';
import 'package:flutter_tek4/models/event.dart';
import 'package:flutter_tek4/pages/new_event/new_event_date.dart';
import 'package:flutter_tek4/pages/new_event/new_event_description.dart';
import 'package:flutter_tek4/pages/new_event/new_event_geopos.dart';
import 'package:flutter_tek4/pages/new_event/new_event_picture.dart';

class CheckIconEventName extends StatelessWidget {
  const CheckIconEventName({
    Key? key,
    required TextEditingController textController,
  })   : _textController = textController,
        super(key: key);

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 50,
        child: RawMaterialButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NewEventPicture(name: this._textController.text)),
            )
          },
          elevation: 2.0,
          fillColor: Theme.of(context).accentColor,
          child: Icon(
            Icons.check,
            color: Theme.of(context).primaryColor,
            size: 30.0,
          ),
          padding: EdgeInsets.all(0.0),
          shape: CircleBorder(),
        ));
  }
}

class CheckIconEventPic extends StatelessWidget {
  const CheckIconEventPic({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 50,
        child: RawMaterialButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewEventDescription(event: this.event)),
            )
          },
          elevation: 2.0,
          fillColor: Theme.of(context).accentColor,
          child: Icon(Icons.check,
              size: 30.0, color: Theme.of(context).primaryColor),
          padding: EdgeInsets.all(0.0),
          shape: CircleBorder(),
        ));
  }
}

class CheckIconEventDescr extends StatelessWidget {
  const CheckIconEventDescr({
    Key? key,
    required this.event,
    required TextEditingController textController,
  })   : _textController = textController,
        super(key: key);

  final Event event;
  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 50,
        child: RawMaterialButton(
          onPressed: () => {
            print(this.event.title),
            this.event.description = _textController.text,
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewEventGeopos(event: this.event)),
            )
          },
          elevation: 2.0,
          fillColor: Theme.of(context).accentColor,
          child: Icon(Icons.check,
              size: 30.0, color: Theme.of(context).primaryColor),
          padding: EdgeInsets.all(0.0),
          shape: CircleBorder(),
        ));
  }
}

class CheckIconEventGeopos extends StatelessWidget {
  const CheckIconEventGeopos({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 50,
        child: RawMaterialButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewEventDate(event: this.event)),
            )
          },
          elevation: 2.0,
          fillColor: Theme.of(context).accentColor,
          child: Icon(Icons.check,
              size: 30.0, color: Theme.of(context).primaryColor),
          padding: EdgeInsets.all(0.0),
          shape: CircleBorder(),
        ));
  }
}
