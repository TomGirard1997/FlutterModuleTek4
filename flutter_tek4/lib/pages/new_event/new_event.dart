import '../../constants/import.dart';

class NewEvent extends StatefulWidget {
  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
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
        NewEventScreen(),
        SizedBox(height: 40),
      ]),
    );
  }
}

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({
    Key? key,
  }) : super(key: key);

  @override
  _NewEventScreenState createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  late TextEditingController _textController;

  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text(
              'Event name :',
              style: CustomStyle.optionStyle(),
            ),
            SizedBox(height: 50),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: 'Enter event name',
                ),
              ),
            ),
            SizedBox(height: 50),
            CheckIconEventName(textController: _textController),
          ])),
    );
  }
}
