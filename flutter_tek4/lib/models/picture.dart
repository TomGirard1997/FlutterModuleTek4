import '../constants/import.dart';

class Picture {
  int id = 0;
  int eventId = 0;
  int profileId = 0;
  Uint8List? data;
  String name = "";
  String comment = "";

  Picture(this.data, this.name, this.comment);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'picture_event_id': eventId,
      'picture_profile_id': profileId,
      'picture_name': name,
      'picture_data': data,
      'picture_comment': comment
    };

    return map;
  }

  Picture.fromMap(Map<String, dynamic> map) {
    id = map['picture_id'];
    eventId = map['picture_event_id'];
    profileId = map['picture_profile_id'];
    name = map['picture_name'];
    data = map['picture_data'];
    comment = map['picture_comment'];
  }
}
