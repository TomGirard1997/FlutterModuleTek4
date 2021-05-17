import 'package:google_maps_flutter/google_maps_flutter.dart';

class Album {
  final String title;
  final LatLng location;
  final String image;

  Album(this.title, this.location, this.image);
}
