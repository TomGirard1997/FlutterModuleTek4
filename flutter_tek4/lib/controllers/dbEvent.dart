import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_tek4/models/picture.dart';
import 'package:flutter_tek4/models/event.dart';

class DBEvent {
  static Database? _db;
  static const String PIC_ID = 'picture_id';
  static const String PIC_NAME = 'picture_name';
  static const String PIC_PATH = 'picture_path';
  static const String PIC_COMMENT = 'picture_comment';
  static const String PIC_EVENT_ID = 'picture_event_id';

  static const String EVENT_ID = 'event_id';
  static const String EVENT_DESCR = 'event_description';
  static const String EVENT_COVER_PIC = 'event_cover_picture';
  static const String EVENT_TITLE = 'event_title';
  static const String EVENT_LAT = 'event_lat';
  static const String EVENT_LONG = 'event_long';


  static const String EVENT_TABLE = 'EventTable';
  static const String PIC_TABLE = 'PicturesTable';
  static const String DB_NAME = 'event.db';
 
  Future<Database?> get db async {
    if (null != _db) {
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
      CREATE TABLE $PIC_TABLE (
            $PIC_ID INTEGER PRIMARY KEY,
            $PIC_EVENT_ID INTEGER PRIMARY KEY,
            $PIC_NAME TEXT,
            $PIC_PATH TEXT,
            $PIC_COMMENT TEXT,

            FOREIGN KEY ($PIC_EVENT_ID) REFERENCES $EVENT_TABLE ($EVENT_ID) 
              ON DELETE NO ACTION ON UPDATE NO ACTION
      )""");

    await db.execute("""
      CREATE TABLE $EVENT_TABLE (
        $EVENT_ID INTEGER PRIMARY KEY,
        $EVENT_DESCR TEXT,
        $EVENT_TITLE TEXT,
        $EVENT_LAT REAL,
        $EVENT_LONG REAL,
        $EVENT_COVER_PIC (
          $PIC_ID INTEGER,
          $PIC_NAME TEXT,
          $PIC_PATH TEXT,
          $PIC_COMMENT TEXT
        )
      )
      """);

  }

  Future<Event> addEvent(Event event) async {
    var dbClient = await db;
    event.id = await dbClient!.insert(EVENT_TABLE, event.toMap());

    return event;
  }

  Future<Picture> addPicture(Picture eventPicture) async {
    var dbClient = await db;
    eventPicture.id = await dbClient!.insert(PIC_TABLE, eventPicture.toMap());

    return eventPicture;
  }
 
  Future<List<Picture>> getPicturesOfEvent(int eventId) async {
    var dbClient = await db;

    List<Map<String, dynamic>> mapsPictures = await dbClient!.query(PIC_TABLE, columns: [PIC_ID, PIC_NAME, PIC_PATH, PIC_COMMENT, EVENT_COVER_PIC]);
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

    List<Map<String, dynamic>> mapsEvents = await dbClient!.query(EVENT_TABLE, columns: [EVENT_ID, EVENT_DESCR, EVENT_TITLE, EVENT_LAT, EVENT_LONG]);
    List<Event> events = [];

    if (mapsEvents.length > 0) {
      for (int i = 0; i < mapsEvents.length; i++) {
        events.add(Event.fromMap(mapsEvents[i]));
      }
    }
    return events;
  }
 
  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }
}
