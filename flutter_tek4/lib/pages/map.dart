import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import '../models/album.dart';
// import '../services/location_album.dart' as locations;

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

  final LatLng _latLng = LatLng(28.7041, 77.1025);
  final double _zoom = 15.0;

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    _listAlbums.forEach((key, value) {
      _markers.add(
        Marker(
            markerId: MarkerId(value.title),
            position: value.location,
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                value.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Image.asset(value.image, height: 75),
                              SizedBox(
                                height: 3.0,
                              ),
                            ],
                          ),
                        ),
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Triangle.isosceles(
                      edge: Edge.BOTTOM,
                      child: Container(
                        color: Colors.white,
                        width: 20.0,
                        height: 10.0,
                      ),
                    ),
                  ],
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
            height: 150,
            width: 200,
            offset: 50,
          ),
        ],
      ),
    );
  }
}
