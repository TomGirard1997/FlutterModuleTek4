import 'dart:async';
import 'dart:io' as io;
import 'package:flutter_tek4/models/profile.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_tek4/models/picture.dart';
import 'package:flutter_tek4/models/event.dart';

class DBHelper {
  static Database? _db;
  static const String PIC_ID = 'picture_id';
  static const String PIC_NAME = 'picture_name';
  static const String PIC_DATA = 'picture_data';
  static const String PIC_COMMENT = 'picture_comment';
  static const String PIC_EVENT_ID = 'picture_event_id';
  static const String PIC_PROFILE_ID = 'picture_profile_id';

  static const String EVENT_ID = 'event_id';
  static const String EVENT_DESCR = 'event_description';
  static const String EVENT_TITLE = 'event_title';
  static const String EVENT_LAT = 'event_lat';
  static const String EVENT_LONG = 'event_long';
  static const String EVENT_DATE = 'event_date';

  static const String PROFILE_ID = 'profile_id';
  static const String PROFILE_FIRSTNAME = 'profile_firstname';
  static const String PROFILE_LASTNAME = 'profile_lastname';
  static const String PROFILE_TITLE = 'profile_title';
  static const String PROFILE_SUBTITLE = 'profile_subtitle';
  static const String PROFILE_TOTAL_EVENTS = 'profile_totalEvents';
  static const String PROFILE_TOTAL_PICTURES = 'profile_totalPictures';
  static const String PROFILE_TOTAL_FESTIVALS = 'profile_totalFestivals';

  static const String PROFILE_TABLE = 'ProfileTable';
  static const String PROFILE_PIC_TABLE = 'ProfilePicTable';
  static const String EVENT_TABLE = 'EventTable';
  static const String PIC_TABLE = 'PicturesTable';
  static const String COVER_PIC_TABLE = 'CoverPictureTable';

  // static const String DB_NAME = 'flu.db';

  // static const String DB_NAME = 'f.db';

  // static const String DB_NAME = 'test.db';

  static const String DB_NAME = 'test4.db';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);

    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE $PROFILE_TABLE (
        $PROFILE_ID INTEGER PRIMARY KEY,
        $PROFILE_FIRSTNAME TEXT,
        $PROFILE_LASTNAME TEXT,
        $PROFILE_TITLE TEXT,
        $PROFILE_SUBTITLE TEXT,
        $PROFILE_TOTAL_EVENTS INTEGER,
        $PROFILE_TOTAL_PICTURES INTEGER,
        $PROFILE_TOTAL_FESTIVALS INTEGER
      )
      """);
    await db.execute("""
      CREATE TABLE $PROFILE_PIC_TABLE (
        $PIC_ID INTEGER PRIMARY KEY,
        $PIC_PROFILE_ID INTEGER,
        $PIC_EVENT_ID INTEGER,
        $PIC_NAME TEXT,
        $PIC_DATA BLOB,
        $PIC_COMMENT TEXT,

        FOREIGN KEY ($PIC_PROFILE_ID) REFERENCES $PROFILE_TABLE ($PROFILE_ID) 
          ON DELETE NO ACTION ON UPDATE NO ACTION
      )
      """);

    await db.execute("""
      CREATE TABLE $PIC_TABLE (
        $PIC_ID INTEGER PRIMARY KEY,
        $PIC_EVENT_ID INTEGER,
        $PIC_PROFILE_ID INTEGER,
        $PIC_NAME TEXT,
        $PIC_DATA BLOB,
        $PIC_COMMENT TEXT,

        FOREIGN KEY ($PIC_EVENT_ID) REFERENCES $EVENT_TABLE ($EVENT_ID) 
          ON DELETE NO ACTION ON UPDATE NO ACTION
      )
      """);

    await db.execute("""
      CREATE TABLE $COVER_PIC_TABLE (
        $PIC_ID INTEGER PRIMARY KEY,
        $PIC_EVENT_ID INTEGER,
        $PIC_PROFILE_ID INTEGER,
        $PIC_NAME TEXT,
        $PIC_DATA BLOB,
        $PIC_COMMENT TEXT,

        FOREIGN KEY ($PIC_EVENT_ID) REFERENCES $EVENT_TABLE ($EVENT_ID) 
          ON DELETE NO ACTION ON UPDATE NO ACTION
      )
      """);

    await db.execute("""
      CREATE TABLE $EVENT_TABLE (
        $EVENT_ID INTEGER PRIMARY KEY,
        $EVENT_DESCR TEXT,
        $EVENT_TITLE TEXT,
        $EVENT_DATE TEXT,
        $EVENT_LAT REAL,
        $EVENT_LONG REAL
      )
      """);
  }

  Future<Profile> addProfile(Profile profile) async {
    var dbClient = await db;

    var profileInDb = await getProfile();
    if (profileInDb != null) {
      profile.id = await dbClient!.update(PROFILE_TABLE, profile.toMap(),
          where: "$PROFILE_ID = ?", whereArgs: [1]);
    } else {
      profile.id = await dbClient!.insert(PROFILE_TABLE, profile.toMap());
    }

    return profile;
  }

  Future<Picture> addProfilePicture(Picture picture) async {
    var dbClient = await db;

    var profileInDb = await getProfile();
    if (profileInDb != null && profileInDb.picture != null) {
      picture.profileId = 1;
      picture.id = await dbClient!.update(PROFILE_PIC_TABLE, picture.toMap(),
          where: "$PIC_PROFILE_ID = ?", whereArgs: [1]);
    } else {
      picture.profileId = 1;
      picture.id = await dbClient!.insert(PROFILE_PIC_TABLE, picture.toMap());
    }

    return picture;
  }

  Future<Event> addEvent(Event event, Picture coverPic) async {
    var dbClient = await db;

    event.id = await dbClient!.insert(EVENT_TABLE, event.toMap());
    coverPic.id = event.id;
    await dbClient.insert(COVER_PIC_TABLE, coverPic.toMap());

    return event;
  }

  Future<Picture> addPicture(Picture eventPicture) async {
    var dbClient = await db;
    eventPicture.id = await dbClient!.insert(PIC_TABLE, eventPicture.toMap());

    return eventPicture;
  }

  Future<int> getTotalEvents() async {
    var dbClient = await db;
    var nbEvents = 0;

    nbEvents = Sqflite.firstIntValue(
        await dbClient!.rawQuery('SELECT COUNT(*) FROM $EVENT_TABLE'));

    return nbEvents;
  }

  Future<int> getTotalPictures() async {
    var dbClient = await db;
    var nbPictures = 0;

    nbPictures = Sqflite.firstIntValue(
        await dbClient!.rawQuery('SELECT COUNT(*) FROM $PIC_TABLE'));

    return nbPictures;
  }

  Future<List<Picture>> getPicturesOfEvent(int eventId) async {
    var dbClient = await db;

    List<Map<String, dynamic>> mapsPictures = await dbClient!.query(PIC_TABLE,
        columns: [PIC_ID, PIC_NAME, PIC_DATA, PIC_COMMENT],
        where: '$PIC_EVENT_ID = ?',
        whereArgs: [eventId]);
    List<Picture> eventPictures = [];

    if (mapsPictures.length > 0) {
      for (int i = 0; i < mapsPictures.length; i++) {
        eventPictures.add(Picture.fromMap(mapsPictures[i]));
      }
    }

    return eventPictures;
  }

  Future<List<Picture>> getAllPicturesOfEvents() async {
    var dbClient = await db;

    List<Map<String, dynamic>> mapsPictures = await dbClient!
        .query(PIC_TABLE, columns: [PIC_ID, PIC_NAME, PIC_DATA, PIC_COMMENT]);
    List<Picture> eventPictures = [];

    if (mapsPictures.length > 0) {
      for (int i = 0; i < mapsPictures.length; i++) {
        eventPictures.add(Picture.fromMap(mapsPictures[i]));
      }
    }

    return eventPictures;
  }

  Future<List<Event>> getAllEvents() async {
    var dbClient = await db;

    List<Map<String, dynamic>> mapsCoverPictures = await dbClient!.query(
        COVER_PIC_TABLE,
        columns: [PIC_ID, PIC_NAME, PIC_DATA, PIC_COMMENT]);
    List<Map<String, dynamic>> mapsEvents = await dbClient.query(EVENT_TABLE,
        columns: [
          EVENT_ID,
          EVENT_DESCR,
          EVENT_TITLE,
          EVENT_LAT,
          EVENT_LONG,
          EVENT_DATE
        ]);
    List<Event> events = [];

    print("mapsEvents: ");
    print(mapsEvents);
    print("coverPictures: ");
    print(mapsCoverPictures);

    if (mapsEvents.length > 0) {
      for (int i = 0; i < mapsEvents.length; i++) {
        events.add(Event.fromMap(mapsEvents[i]));
        events[i].coverPicture = Picture.fromMap(mapsCoverPictures[i]);
      }
    }

    return events;
  }

  Future<Profile?> getProfile() async {
    var dbClient = await db;

    List<Map<String, dynamic>> profileMap = await dbClient!.query(PROFILE_TABLE,
        columns: [
          PROFILE_ID,
          PROFILE_FIRSTNAME,
          PROFILE_LASTNAME,
          PROFILE_TITLE,
          PROFILE_SUBTITLE,
          PROFILE_TOTAL_EVENTS,
          PROFILE_TOTAL_PICTURES,
          PROFILE_TOTAL_FESTIVALS
        ],
        where: '$PROFILE_ID = ?',
        whereArgs: [1]);
    List<Map<String, dynamic>> profilePictureMap = await dbClient.query(
        PROFILE_PIC_TABLE,
        columns: [PIC_ID, PIC_NAME, PIC_DATA, PIC_COMMENT],
        where: '$PIC_PROFILE_ID = ?',
        whereArgs: [1]);

    if (profileMap.length == 0) {
      return null;
    }
    var profile = Profile.fromMap(profileMap[0]);

    if (profilePictureMap.length != 0) {
      var profilePicture = Picture.fromMap(profilePictureMap[0]);
      profile.picture = profilePicture;
    }

    return profile;
  }

  Future<int> deletePicture(int pictureId) async {
    var dbClient = await db;

    int result = await dbClient!
        .delete(PIC_TABLE, where: "$PIC_ID = ?", whereArgs: [pictureId]);

    return result;
  }

  Future<int> deleteEvent(int eventId) async {
    var dbClient = await db;

    int result = await dbClient!
        .delete(PIC_TABLE, where: "$PIC_EVENT_ID = ?", whereArgs: [eventId]);

    return result;
  }
}
