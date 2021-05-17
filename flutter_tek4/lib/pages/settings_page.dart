import '../constants/import.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late Settings setting;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            currentTheme.switchTheme();
          },
          label: Text('Switch Theme'),
          icon: Icon(Icons.brightness_high),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
              SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.image_search),
                    InkWell(
                        child: Text('About Memories Book',
                            style: TextStyle(fontSize: custFontSize)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AboutUs()),
                          );
                        })
                  ]),
              SizedBox(height: 20),
              const Divider(
                height: 20,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.help),
                  InkWell(
                      child: Text('Help',
                          style: TextStyle(fontSize: custFontSize)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Help()),
                        );
                      }),
                ],
              ),
              SizedBox(height: 20),
              const Divider(
                height: 20,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.format_size),
                    Text(
                      'Change text size',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: custFontSize),
                    ),
                  ]),
              Slider(
                value: custFontSize,
                min: 15,
                max: 35,
                divisions: 3,
                label: custFontSize.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    custFontSize = value;
                  });
                },
              ),
              const Divider(
                height: 20,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
            ])));
  }
}
