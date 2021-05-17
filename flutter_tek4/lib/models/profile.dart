import '../constants/import.dart';

class Profile {
  Picture? picture;

  int id = 0;
  String firstname = "";
  String lastname = "";
  String title = "";
  String subtitle = "";
  int totalEvents = 0;
  int totalPictures = 0;
  int totalFestivals = 0;

  Profile(
    this.firstname,
    this.lastname,
    this.title,
    this.subtitle,
    this.totalEvents,
    this.totalPictures,
    this.totalFestivals,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'profile_firstName': firstname,
      'profile_lastName': lastname,
      'profile_title': title,
      'profile_subtitle': subtitle,
      'profile_totalEvents': totalEvents,
      'profile_totalPictures': totalPictures,
      'profile_totalFestivals': totalFestivals
    };

    return map;
  }

  Profile.fromMap(Map<dynamic, dynamic> map) {
    firstname = map['profile_firstname'];
    lastname = map['profile_lastname'];
    title = map['profile_title'];
    subtitle = map['profile_subtitle'];
    totalEvents = map['profile_totalEvents'];
    totalPictures = map['profile_totalPictures'];
    totalFestivals = map['profile_totalFestivals'];
  }
}
