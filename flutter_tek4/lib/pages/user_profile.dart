import 'package:flutter/material.dart';
import 'package:flutter_tek4/appdata/appdata.dart';
import 'package:flutter_tek4/models/profile.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Profile profile;

  @override
  void initState() {
    profile = AppData.profiles[0];
    super.initState();
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
          for (int i = 0; i < AppData.imageContents.length; i++)
            Container(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppData.imageContents[i].imageUrl),
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
          Container(
              height: 110,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: AssetImage(AppData.profiles[0].imageUrl),
                      fit: BoxFit.cover))),
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
