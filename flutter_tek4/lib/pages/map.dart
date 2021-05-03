import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import '../models/album.dart';
// import '../services/location_album.dart' as locations;

import 'dart:ui' as ui;

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Map<String, Album> _listAlbums = {
    "canada": Album("Canada Deers", LatLng(46.829853, -71.254028),
        "assets/images/content/johan-mouchet-VyZTJ_FRqJc-unsplash (1).jpg"),
    "congo": Album("Congo Lions", LatLng(-0.6605788, 14.8965794),
        "assets/images/content/timon-studler-4qmXhKJhSo4-unsplash.jpg"),
    "scotland": Album("Scotland Dogs", LatLng(55.860916, -4.251433),
        "assets/images/content/jason-wolf-gLb1K2OXQ00-unsplash.jpg"),
  };

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final LatLng _latLng = LatLng(0, -30);
  final double _zoom = 2.0;

  late final markerIcon;

  @override
  void initState() {
    super.initState();
  }

  void setCustomPin() async {
    markerIcon = await getBytesFromAsset('assets/images/camera.png', 80);
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

  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    BitmapDescriptor customIcon;
    setCustomPin();
    if (markerIcon != null) {
      customIcon = BitmapDescriptor.fromBytes(markerIcon);
    } else {
      customIcon = BitmapDescriptor.defaultMarker;
    }
    _listAlbums.forEach((key, value) {
      _markers.add(
        Marker(
            icon: customIcon,
            markerId: MarkerId(value.title),
            position: value.location,
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Card(
                  elevation: 5.0,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(value.title, style: TextStyle(fontSize: 14)),
                      SizedBox(
                        height: 3,
                      ),
                      Image.asset(value.image,
                          fit: BoxFit.fitWidth, height: 110),
                      TextButton(
                        onPressed: () {
                          // Perform some action
                        },
                        child: Text('Access to Album',
                            style:
                                TextStyle(fontSize: 10, color: Colors.orange)),
                      ),
                    ],
                  ),
                ),
                value.location,
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
