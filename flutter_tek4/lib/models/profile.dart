import 'package:flutter_tek4/models/picture.dart';

class Profile {
  Picture? picture;

  int id = 0;
  String firstname = "";
  String lastname = "";
  String title = "";
  String subtitle = "";
  int totalAlbums = 0;
  int totalPictures = 0;
  int totalFestivals = 0;

  Profile({
    this.firstname = "",
    this.lastname = "",
    this.title = "",
    this.subtitle = "",
    this.totalAlbums = 0,
    this.totalPictures = 0,
    this.totalFestivals = 0,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'profile_firstName': firstname,
      'profile_lastName': lastname,
      'profile_title': title,
      'profile_subtitle': subtitle,
      'profile_totalAlbums': totalAlbums,
      'profile_totalPictures': totalPictures,
      'profile_totalFestivals': totalFestivals
    };
    
    return map;
  }

  Profile.fromMap(Map<String, dynamic> map) {
    firstname = map['profile_firstname'];
    lastname = map['profile_lastname'];
    title = map['profile_title'];
    subtitle = map['profile_subtitle'];
    totalAlbums = map['profile_totalAlbums'];
    totalPictures = map['profile_totalPictures'];
    totalFestivals = map['profile_totalFestivals'];
  }

}
