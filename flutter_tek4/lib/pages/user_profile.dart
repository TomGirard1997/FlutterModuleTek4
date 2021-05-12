import 'dart:io';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tek4/appdata/appdata.dart';
import 'package:flutter_tek4/models/profile.dart';
import 'package:flutter_tek4/models/picture.dart';
import 'package:flutter_tek4/models/event.dart';
import 'package:flutter_tek4/controllers/dbHelper.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Profile profile;
  late DBHelper dbEvent;
  List<Picture>? pictures;

  @override
  initState() {
    super.initState();

    profile = AppData.profiles[0];

  }

  Future initDb() async {
    //test
    WidgetsFlutterBinding.ensureInitialized();
    dbEvent = DBHelper();
    
    var coverPictureTest = AppData.imageContents[0];
    var eventTest = Event("1st event", "This is the first event", 1.0, 1.0);
    
    var eventRes = await dbEvent.addEvent(eventTest, coverPictureTest);
    
    var eventPic1 = AppData.imageContents[1];
    eventPic1.eventId = eventRes.id;
    var eventPic2 = AppData.imageContents[2];
    eventPic2.eventId = eventRes.id;
    dbEvent.addPicture(eventPic1);
    dbEvent.addPicture(eventPic2);

    var futurePicts = await dbEvent.getPicturesOfEvent(eventRes.id);
    
    setState(() {
      pictures = futurePicts;
    });
    
    //test 
  }

  @override
  Widget build(BuildContext context) {
    initDb();

    return Scaffold(
      body: ListView(children: <Widget>[
        SizedBox(height: 20),
        HeaderSection(),
        SizedBox(height: 40),
        Container(
            child: Wrap(children: <Widget>[
            if (pictures != null)
              for (int i = 0; i < pictures!.length; i++)
                Container(
                  height: MediaQuery.of(context).size.width / 3,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(pictures![i].path),
                          fit: BoxFit.cover)),
                )
          ]))
      ]),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TakeProfilePictureSection(),
          SizedBox(height: 20),
          Text(
            AppData.profiles[0].title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          SizedBox(height: 20),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppData.profiles[0].subtitle,
                textAlign: TextAlign.center,
              )),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 56),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      AppData.profiles[0].totalAlbums,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.amber[800]),
                    ),
                    Text('Albums')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      AppData.profiles[0].totalPictures,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.amber[800]),
                    ),
                    Text('Pictures')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      AppData.profiles[0].totalFestivals,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.amber[800]),
                    ),
                    Text('Festivals')
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TakeProfilePictureSection extends StatefulWidget {
  const TakeProfilePictureSection({
    Key? key,
  }) : super(key: key);

  @override
  _TakeProfilePictureSectionState createState() =>
      _TakeProfilePictureSectionState();
}

class _TakeProfilePictureSectionState extends State<TakeProfilePictureSection> {
  PickedFile? _pickedImage;
  final picker = ImagePicker();

  ImageProvider<Object>? imageTodisplay = AssetImage(AppData.profiles[0].imageUrl);

  @override
  void initState() {
    imageTodisplay = AssetImage(AppData.profiles[0].imageUrl);

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
              height: 110,
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
