import '../../constants/import.dart';

class NewEventGeopos extends StatefulWidget {
  NewEventGeopos({@required this.event});
  final event;

  @override
  _NewEventGeoposState createState() => _NewEventGeoposState(event: event);
}

class _NewEventGeoposState extends State<NewEventGeopos> {
  _NewEventGeoposState({@required this.event});
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
        body: Container(
            child: Center(
          child: Column(children: <Widget>[
            SizedBox(height: 80),
            EventGeoposScreen(event: event),
            SizedBox(height: 40),
          ]),
        )));
  }
}

class EventGeoposScreen extends StatefulWidget {
  EventGeoposScreen({required this.event});

  final Event event;

  @override
  _EventGeoposScreenState createState() =>
      _EventGeoposScreenState(event: event);
}

class _EventGeoposScreenState extends State<EventGeoposScreen> {
  _EventGeoposScreenState({required this.event});

  final Event event;
  final LatLng _latLng = LatLng(0, -30);

  final double _zoom = 2.0;

  late final TextEditingController _textController = TextEditingController();

  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  Set<Marker> _markers = {};
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void handleTap(LatLng point) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'I am a marker',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
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
              'Event Geoposition :',
              style: CustomStyle.optionStyle(),
            ),
            SizedBox(height: 25),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                  markers: _markers,
                  initialCameraPosition: CameraPosition(
                    target: _latLng,
                    zoom: _zoom,
                  ),
                  // all the other arguments
                  onCameraMove: (position) {
                    _customInfoWindowController.onCameraMove!();
                  },
                  onTap: (latLng) {
                    this.event.lat = latLng.latitude;
                    this.event.long = latLng.longitude;
                    handleTap(latLng);
                  }),
            ),
            SizedBox(height: 25),
            CheckIconEventGeopos(event: event),
          ])),
    );
  }
}
