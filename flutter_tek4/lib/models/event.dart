import 'package:flutter_tek4/models/picture.dart';

class Event {

  Picture? coverPicture;

  int id = 0;
  String title = "";
  String description = "";
  num lat = 0.0;
  num long = 0.0;

  Event(this.title, this.description, this.lat, this.long);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'event_title': title,
      'event_description': description,
      'event_lat': lat,
      'event_long': long
    };
    
    return map;
  }

  Event.fromMap(Map<String, dynamic> map) {
    id = map['event_id'];
    title = map['event_title'];
    description = map['event_description'];
    lat = map['event_lat'];
    long = map['event_long'];
  }
}