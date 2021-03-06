import '../../constants/import.dart';

class NewEventPicture extends StatefulWidget {
  NewEventPicture({@required this.name});
  final name;

  @override
  _NewEventPictureState createState() => _NewEventPictureState(name: name);
}

class _NewEventPictureState extends State<NewEventPicture> {
  _NewEventPictureState({@required this.name});
  final name;

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
        MainSection(name: name),
        SizedBox(height: 40),
      ]),
    );
  }
}

class MainSection extends StatelessWidget {
  MainSection({@required this.name});

  final name;
  late final event = Event(this.name, "no description", "", 1.0, 1.0);

  void onSubmit(pickedFile) async {
    var imageDatas = await pickedFile!.readAsBytes();
    Picture? coverPicture = Picture(imageDatas, "main picture", " ");
    event.coverPicture = coverPicture;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text(
              'Event picture :',
              style: CustomStyle.optionStyle(),
            ),
            SizedBox(height: 50),
            TakePictureSection(onSubmit: this.onSubmit),
            SizedBox(height: 50),
            CheckIconEventPic(event: event),
          ])),
    );
  }
}

class TakePictureSection extends StatefulWidget {
  const TakePictureSection({Key? key, required this.onSubmit})
      : super(key: key);

  final Function onSubmit;

  @override
  _TakePictureSectionState createState() =>
      _TakePictureSectionState(onSubmit: onSubmit);
}

class _TakePictureSectionState extends State<TakePictureSection> {
  _TakePictureSectionState({required this.onSubmit});

  final Function onSubmit;
  PickedFile? _pickedImage;
  final picker = ImagePicker();

  ImageProvider<Object>? imageTodisplay =
      AssetImage('assets/images/content/hu-chen-60XLoOgwkfA-unsplash.jpg');

  @override
  void initState() {
    imageTodisplay =
        AssetImage('assets/images/content/hu-chen-60XLoOgwkfA-unsplash.jpg');

    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _pickedImage = PickedFile(pickedFile.path);
        imageTodisplay = FileImage(File(_pickedImage!.path));
        onSubmit(pickedFile);
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
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: imageTodisplay!, fit: BoxFit.cover))),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 90),
              child: SizedBox(
                  height: 40,
                  width: 40,
                  child: RawMaterialButton(
                    onPressed: () => getImage(),
                    elevation: 2.0,
                    fillColor: Theme.of(context).accentColor,
                    child: Icon(Icons.add_a_photo_outlined,
                        size: 30.0, color: Theme.of(context).primaryColor),
                    padding: EdgeInsets.all(5.0),
                    shape: CircleBorder(),
                  ))),
        ]));
  }
}
