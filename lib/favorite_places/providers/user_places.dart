import 'dart:io';

import 'package:first_web/favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

const userPlacesTableName = 'user_places';

Future<Database> get database async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'place.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE $userPlacesTableName(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
    version: 1,
  );

  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  // different OS possibly delete temporary Image directory, so first create safe file path
  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy(path.join(appDir.path, fileName));

    final newPlace =
        Place(title: title, image: copiedImage, location: location);

    final db = await database;

    db.insert(
      userPlacesTableName,
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': copiedImage.path,
        'lat': newPlace.location.latitude,
        'lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );
    state = [newPlace, ...state];
  }

  Future<void> loadPlaces() async {
    final db = await database;

    final data = await db.query(userPlacesTableName);
    final userPlaces = data.map(
      (row) => Place(
        id: row['id'] as String,
        title: row['title'] as String,
        image: File(row['image'] as String),
        location: PlaceLocation(
            latitude: row['lat'] as double,
            longitude: row['lng'] as double,
            address: row['address'] as String),
      ),
    ).toList();

    state = userPlaces;
  }

  void removePlace(Place place) {
    state = state.where((oldPlace) => place.id != oldPlace.id).toList();
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());
