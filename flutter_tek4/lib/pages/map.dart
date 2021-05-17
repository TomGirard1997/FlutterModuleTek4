import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tek4/controllers/dbHelper.dart';
import 'package:flutter_tek4/pages/eventVue.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import '../models/album.dart';
import 'package:flutter_tek4/models/event.dart';

// import '../services/location_album.dart' as locations;

import 'dart:ui' as ui;

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final LatLng _latLng = LatLng(0, -30);
  final double _zoom = 1.0;
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;

  late final markerIcon;
  Set<Marker> _markers = {};

  DBHelper dbClient = DBHelper();

  List<Event>? events;

  @override
  void initState() {
    super.initState();
    initDatas();
    setCustomPin();
  }

  Future initDatas() async {
    var futureEvent = await dbClient.getAllEvents();
    setState(() {
      events = futureEvent;
    });
  }

  void setCustomPin() async {
    markerIcon = await getBytesFromAsset('assets/images/camera.png', 80);
    setState(() {
      customIcon = BitmapDescriptor.fromBytes(markerIcon);
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    events?.forEach((event) {
      _markers.add(
        Marker(
            icon: customIcon,
            markerId: MarkerId(event.title),
            position: LatLng(event.lat as double, event.long as double),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Card(
                  elevation: 5.0,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(event.title, style: TextStyle(fontSize: 14)),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                          height: 110,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: Image.memory(event.coverPicture!.data!)
                                      .image,
                                  fit: BoxFit.fitWidth))),
                      Flexible(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventVue(event: event)),
                            );
                          },
                          child: Text('Access to Album',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.orange)),
                        ),
                      ),
                    ],
                  ),
                ),
                LatLng(event.lat as double, event.long as double),
              );
            }),
      );
    });

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) async {
              _customInfoWindowController.googleMapController = controller;
            },
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: _latLng,
              zoom: _zoom,
            ),
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            width: 200,
            height: 200,
          ),
        ],
      ),
    );
  }
}
