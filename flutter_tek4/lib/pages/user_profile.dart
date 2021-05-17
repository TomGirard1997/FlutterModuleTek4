import '../constants/import.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  DBHelper dbClient = DBHelper();

  List<Picture>? pictures;
  Profile? profile;

  @override
  initState() {
    super.initState();

    initDatas();
  }

  Future initDatas() async {
    var futurePictures = await dbClient.getAllPicturesOfEvents();
    var futureProfile = await dbClient.getProfile();

    setState(() {
      pictures = futurePictures;
      profile = futureProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        image: Image.memory(pictures![i].data!).image,
                        fit: BoxFit.cover)),
              )
        ]))
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
  DBHelper dbClient = DBHelper();

  Profile? profile;

  var totalEvents = 0;
  var totalPictures = 0;
  var totalFestivals = 0;

  @override
  initState() {
    super.initState();

    initDatas();
  }

  displayCreateProfileDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit profile'),
            content:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              TextField(
                  onChanged: (firstname) {
                    setState(() {
                      profile?.firstname = firstname;
                    });
                  },
                  decoration: new InputDecoration(hintText: "Your firstname")),
              TextField(
                  onChanged: (lastname) {
                    setState(() {
                      profile?.lastname = lastname;
                    });
                  },
                  decoration: new InputDecoration(hintText: "Your lastname")),
              TextField(
                  onChanged: (title) {
                    setState(() {
                      profile?.title = title;
                    });
                  },
                  decoration: new InputDecoration(hintText: "Your description"))
            ]),
            actions: <Widget>[
              new TextButton(
                  child: new Text('Submit'),
                  onPressed: () {
                    print("(submit profile) firstname" + profile!.firstname);
                    dbClient.addProfile(profile!);
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  Future initDatas() async {
    var futureProfile = await dbClient.getProfile();
    var futureTotalEvents = await dbClient.getTotalEvents();
    var futureTotalPictures = await dbClient.getTotalPictures();

    setState(() {
      profile = futureProfile;
      totalEvents = futureTotalEvents;
      totalPictures = futureTotalPictures;
    });

    if (profile == null) {
      profile = Profile("NaN", "NaN", "NaN", "NaN", 0, 0, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TakeProfilePictureSection(),
          SizedBox(height: 20),
          TextButton(
            child: Text('Edit profile'),
            onPressed: displayCreateProfileDialog,
          ),
          Text(
            profile != null
                ? profile!.firstname + " " + profile!.lastname
                : "NaN",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          SizedBox(height: 20),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                profile != null ? profile!.title : "NaN",
                textAlign: TextAlign.center,
              )),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 56),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      profile != null ? totalEvents.toString() : "0",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.amber[800]),
                    ),
                    Text('Events')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      profile != null ? totalPictures.toString() : "0",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.amber[800]),
                    ),
                    Text('Pictures')
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

  ImageProvider<Object>? profilePicture;

  Profile? profile;
  DBHelper dbClient = DBHelper();

  @override
  void initState() {
    super.initState();

    initDatas();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    var imageDatas = await pickedFile?.readAsBytes();

    if (imageDatas != null) {
      setState(() {
        if (pickedFile != null) {
          _pickedImage = PickedFile(pickedFile.path);
          var profilePictureToInsert = Picture(imageDatas, "profile pic", "");
          dbClient.addProfilePicture(profilePictureToInsert);

          profilePicture = FileImage(File(_pickedImage!.path));
        } else {
          print('No image selected.');
        }
      });
    }
  }

  Future initDatas() async {
    var futureProfile = await dbClient.getProfile();

    setState(() {
      profile = futureProfile;

      if (profile != null && profile!.picture != null) {
        profilePicture = Image.memory(profile!.picture!.data!).image;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    profilePicture = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          if (profilePicture != null)
            Container(
                height: 110,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: profilePicture!, fit: BoxFit.cover))),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: SizedBox(
                height: 30,
                width: 30,
                child: RawMaterialButton(
                  onPressed: () => getImage(),
                  elevation: 2.0,
                  fillColor: Theme.of(context).accentColor,
                  child: Icon(Icons.add_a_photo_outlined,
                      size: 20.0, color: Theme.of(context).primaryColor),
                  padding: EdgeInsets.all(5.0),
                  shape: CircleBorder(),
                )),
          ),
        ]));
  }
}
