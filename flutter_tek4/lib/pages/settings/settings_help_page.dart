import '../../constants/import.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memories Book'),
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.all(25),
          padding: EdgeInsets.all(15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('How Memories Book works?',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center),
                SizedBox(height: 10),
                Icon(Icons.home),
                Text('Home, it is where you can create a new memory album.'),
                Text('You can also retreive your recents created albums.'),
                SizedBox(height: 15),
                Icon(Icons.perm_identity),
                Text(
                    'Profil, here you can change your profil picture but also see all your pictures.'),
                SizedBox(height: 15),
                Icon(Icons.settings),
                Text(
                    'Parameters, here you can change the theme of the application (dark or light), change the size of the text, and finally learn more about Memories Book.')
              ])),
    );
  }
}
