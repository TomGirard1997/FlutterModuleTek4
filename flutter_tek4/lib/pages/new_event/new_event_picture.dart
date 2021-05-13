import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tek4/pages/new_event/new_event_description.dart';
import 'package:image_picker/image_picker.dart';

class NewEventPicture extends StatefulWidget {
  @override
  _NewEventPictureState createState() => _NewEventPictureState();
}

class _NewEventPictureState extends State<NewEventPicture> {

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
            'Event picture :',
            style: optionStyle,
          ),
          SizedBox(height: 50),
          TakePictureSection(),
          SizedBox(height: 50),
          SizedBox(
              height: 50,
              width: 50,
              child: RawMaterialButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewEventDescription()),
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

class TakePictureSection extends StatefulWidget {
  const TakePictureSection({
    Key? key,
  }) : super(key: key);

  @override
  _TakePictureSectionState createState() =>
      _TakePictureSectionState();
}

class _TakePictureSectionState extends State<TakePictureSection> {
  PickedFile? _pickedImage;
  final picker = ImagePicker();

  ImageProvider<Object>? imageTodisplay = AssetImage('assets/images/content/hu-chen-60XLoOgwkfA-unsplash.jpg');

  @override
  void initState() {
    imageTodisplay = AssetImage('assets/images/content/hu-chen-60XLoOgwkfA-unsplash.jpg');

    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _pickedImage = PickedFile(pickedFile.path);
        imageTodisplay = FileImage(File(_pickedImage!.path));
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {

  imageTodisplay = null;
  super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: imageTodisplay!,
                      fit: BoxFit.cover))),
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
        ]));
  }
}
