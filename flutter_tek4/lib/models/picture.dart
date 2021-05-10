class Picture {
  int id = 0;
  String data = "";
  String name = "";
  String comment = "";

  Picture(this.id, this.name, this.comment);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'picture_name': name,
      'picture_data': data,
      'picture_comment': comment
    };
    
    return map;
  }

  Picture.fromMap(Map<String, dynamic> map) {
    id = map['picture_id'];
    name = map['picture_name'];
    data = map['picture_data'];
    comment = map['picture_comment'];
  }
}