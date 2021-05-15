import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tek4/pages/new_event/new_event_date.dart';
import 'package:flutter_tek4/models/event.dart';
import 'package:image_picker/image_picker.dart';

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

class HeaderSection extends StatefulWidget {

  HeaderSection({required this.event});

  final Event event;
  static const TextStyle titleStyle = TextStyle(
      fontSize: 35, fontFamily: 'Pacifico');

  static const TextStyle descriptionStyle = TextStyle(
      fontSize: 20, fontFamily: 'Pacifico');

  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  PickedFile? _pickedImage;
  final picker = ImagePicker();

  ImageProvider<Object>? imageTodisplay = AssetImage('assets/images/content/hu-chen-60XLoOgwkfA-unsplash.jpg');

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _pickedImage = PickedFile(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            widget.event.title,
            style: HeaderSection.titleStyle,
          ),
          SizedBox(height: 20),
          Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: Image.memory(widget.event.coverPicture!.data!).image,
                      fit: BoxFit.cover))),
          SizedBox(height: 50),
          Text(
            widget.event.description,
            style: HeaderSection.descriptionStyle,
          ),
          SizedBox(
              height: 50,
              width: 50,
              child: RawMaterialButton(
                onPressed: () => getImage(),
                elevation: 2.0,
                fillColor: Colors.white,
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 30.0,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              )),
        ])
      ),
    );
  }
}
