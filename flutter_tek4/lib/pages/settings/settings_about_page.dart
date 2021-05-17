import '../../constants/import.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memories Book'),
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.all(30),
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Who are we?', style: TextStyle(color: Colors.blue)),
                Text(
                    'We are 4 students of Epitech who are working on this project for the module Flutter'),
                SizedBox(height: 20),
                Text('Why Memories Book?',
                    style: TextStyle(color: Colors.blue)),
                Text(
                    'Our goal is to give the possibility to anyone to keep a memory of the best moments of his life'),
                SizedBox(height: 20),
                Text(
                    'I have a feedback/recommandation, where can i contact you?',
                    style: TextStyle(color: Colors.blue)),
                Text('For any request, you can contact us by email:'),
                SizedBox(height: 5),
                Text('gurvan.menguy@epitech.eu'),
                SizedBox(height: 5),
                Text('tom.girard@epitech.eu'),
                SizedBox(height: 5),
                Text('enki.corbin@epitech.eu'),
                SizedBox(height: 5),
                Text('charles.grandjean@epitech.eu'),
                SizedBox(height: 20),
                Text(
                    'Follow us in social medias to stay update about Memories Book !',
                    style: TextStyle(color: Colors.blue)),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/socialmedias/instagram.png',
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(width: 20),
                      Image.asset(
                        'assets/images/socialmedias/twitter.png',
                        height: 100,
                        width: 100,
                      )
                    ])
              ])),
    );
  }
}
