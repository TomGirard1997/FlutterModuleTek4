import '../constants/import.dart';

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
        EventVueScreen(event: event),
        SizedBox(height: 40),
      ]),
    );
  }
}

class EventVueScreen extends StatefulWidget {
  EventVueScreen({required this.event});

  final Event event;
  static const TextStyle titleStyle =
      TextStyle(fontSize: 35, fontFamily: 'Pacifico');

  static const TextStyle descriptionStyle =
      TextStyle(fontSize: 20, fontFamily: 'Pacifico');

  @override
  _EventVueScreenState createState() => _EventVueScreenState(event: event);
}

class _EventVueScreenState extends State<EventVueScreen> {
  _EventVueScreenState({required this.event});

  final Event event;
  late final pickedFile;
  DBHelper dbClient = DBHelper();
  List<Picture>? pictures;

  @override
  initState() {
    super.initState();

    initDatas();
  }

  Future initDatas() async {
    var futurePictures = await dbClient.getPicturesOfEvent(event.id);

    setState(() {
      pictures = futurePictures;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text(
              widget.event.date,
              style: EventVueScreen.descriptionStyle,
            ),
            Text(
              widget.event.title,
              style: EventVueScreen.titleStyle,
            ),
            SizedBox(height: 20),
            Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: Image.memory(widget.event.coverPicture!.data!)
                            .image,
                        fit: BoxFit.cover))),
            SizedBox(height: 30),
            Text(
              widget.event.description,
              style: EventVueScreen.descriptionStyle,
            ),
            SizedBox(height: 20),
            SizedBox(
                height: 50,
                width: 50,
                child: RawMaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return MyDialog(event: event, submit: initDatas);
                        });
                  },
                  elevation: 2.0,
                  fillColor: Theme.of(context).accentColor,
                  child: Icon(Icons.add_a_photo_outlined,
                      size: 30.0, color: Theme.of(context).primaryColor),
                  shape: CircleBorder(),
                )),
            SizedBox(height: 30),
            Container(
                child: Wrap(children: <Widget>[
              if (pictures != null)
                for (int i = 0; i < pictures!.length; i++)
                  PictureItemSection(picture: pictures![i])
            ]))
          ])),
    );
  }
}

class PictureItemSection extends StatelessWidget {
  PictureItemSection({required this.picture});

  final Picture picture;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      SizedBox(width: 30),
      Text(
        picture.name,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
      ),
      SizedBox(width: 30),
      Container(
          height: MediaQuery.of(context).size.width - 20,
          width: MediaQuery.of(context).size.width - 10,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.memory(picture.data!).image,
                  fit: BoxFit.cover))),
      SizedBox(height: 30),
      Text(
        picture.comment,
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
      ),
      SizedBox(height: 50),
    ]));
  }
}

class MyDialog extends StatefulWidget {
  MyDialog({required this.event, required this.submit});

  final Event event;
  final Function submit;

  @override
  _MyDialogState createState() =>
      new _MyDialogState(event: event, submit: submit);
}

class _MyDialogState extends State<MyDialog> {
  _MyDialogState({required this.event, required this.submit});

  final Event event;
  final Function submit;

  late final pickedFile;
  Profile? profile;
  DBHelper dbClient = DBHelper();

  @override
  initState() {
    super.initState();

    initDatas();
  }

  Future initDatas() async {
    var futureProfile = await dbClient.getProfile();

    setState(() {
      profile = futureProfile;
    });

    if (profile == null) {
      profile = Profile("NaN", "NaN", "NaN", "NaN", 0, 0, 0);
    }
  }

  PickedFile? _pickedImage;
  final picker = ImagePicker();
  ImageProvider<Object>? imageTodisplay =
      AssetImage('assets/images/content/hu-chen-60XLoOgwkfA-unsplash.jpg');
  var comment;
  var name;

  void save(context) async {
    var imageDatas = await pickedFile!.readAsBytes();
    var picture = Picture(imageDatas, name, comment);
    print("event id: ${event.id} profile id : ${profile!.id}");
    picture.eventId = event.id;
    picture.profileId = profile!.id;
    dbClient.addPicture(picture);
    Navigator.of(context).pop();
    submit();
  }

  Future getImage() async {
    pickedFile = await picker.getImage(source: ImageSource.gallery);

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
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add a picture'),
      content: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageTodisplay!, fit: BoxFit.cover))),
              SizedBox(height: 20),
              SizedBox(
                  height: 50,
                  width: 50,
                  child: RawMaterialButton(
                    onPressed: () => getImage(),
                    elevation: 2.0,
                    fillColor: Theme.of(context).accentColor,
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      size: 30.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    shape: CircleBorder(),
                  )),
              TextField(
                  onChanged: (_name) {
                    name = _name;
                  },
                  decoration: new InputDecoration(hintText: "Picture name")),
              TextField(
                  onChanged: (_comment) {
                    comment = _comment;
                  },
                  decoration: new InputDecoration(hintText: "Picture comment")),
            ]),
      ),
      actions: <Widget>[
        new TextButton(
            child: new Text('Submit'),
            onPressed: () {
              save(context);
            })
      ],
    );
  }
}
