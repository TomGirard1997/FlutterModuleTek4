class Picture {
  int id = 0;
  int eventId = 0;
  String path = "";
  String name = "";
  String comment = "";

  Picture(this.path, this.name, this.comment);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'picture_event_id': this.eventId,
      'picture_name': name,
      'picture_path': path,
      'picture_comment': comment
    };
    
    return map;
  }

  Picture.fromMap(Map<String, dynamic> map) {
    id = map['picture_id'];
    eventId = map['picture_event_id'];
    name = map['picture_name'];
    path = map['picture_path'];
    comment = map['picture_comment'];
  }
}