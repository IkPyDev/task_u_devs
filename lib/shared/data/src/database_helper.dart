import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/model/calender_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'mydatabase.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE event(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT,
            location TEXT,
            day INTEGER,
            month INTEGER,
            year INTEGER,
            color INTEGER,
            millisecond INTEGER,
            startTime TEXT,
            endTime TEXT
          )
        ''');
      },
    );
  }

  // Add a new record
  Future<int> addItem(CalendarModel item) async {
    final db = await database;
    return await db.insert('event', item.toJson());
  }

  // Edit an existing record
  Future<int> updateItem(int id, CalendarModel item) async {
    final db = await database;
    return await db.update('event', item.toJson(), where: 'id = ?', whereArgs: [id]);
  }

  // Delete a record
  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete('event', where: 'id = ?', whereArgs: [id]);
  }

  // Get all records
  Future<List<CalendarModel>> getAllItems() async {
    final db = await database;
    final result = await db.query('event');
    return result.isNotEmpty
        ? result.map((item) => CalendarModel.fromJson(item)).toList()
        : [];
  }

  // Get an item by id
  Future<CalendarModel?> getItemById(int id) async {
    final db = await database;
    final result = await db.query('event', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? CalendarModel.fromJson(result.first) : null;
  }

  // Get events within a time range
  Future<List<CalendarModel>> getItemsByTimeRange(int startTime, int endTime) async {
    final db = await database;
    final result = await db.query(
      'event',
      where: 'startTime >= ? AND endTime <= ?',
      whereArgs: [startTime, endTime],
    );
    return result.isNotEmpty
        ? result.map((item) => CalendarModel.fromJson(item)).toList()
        : [];
  }
  Future<List<int>> getColorsForDay(int day, int month, int year) async {
    final db = await database;
    final result = await db.query(
      'event',
      columns: ['color'],
      where: 'day = ? AND month = ? AND year = ?',
      whereArgs: [day, month, year],
    );
    return result.map((item) => item['color'] as int).toList();
  }

  Future<List<CalendarModel>> getItemsByDay(int day, int month, int year) async {
    final db = await database;
    final result = await db.query(
      'event',
      where: 'day = ? AND month = ? AND year = ?',
      whereArgs: [day, month, year],
    );
    return result.isNotEmpty
        ? result.map((item) => CalendarModel.fromJson(item)).toList()
        : [];
  }

  Future<List<CalendarModel>> getItemsByMonth(int month, int year) async {
    final db = await database;
    final result = await db.query(
      'event',
      where: 'month = ? AND year = ?',
      whereArgs: [month, year],
    );
    return result.isNotEmpty
        ? result.map((item) => CalendarModel.fromJson(item)).toList()
        : [];
  }

  Future<List<CalendarModel>> getItemsByYear(int year) async {
    final db = await database;
    final result = await db.query(
      'event',
      where: 'year = ?',
      whereArgs: [year],
    );
    return result.isNotEmpty
        ? result.map((item) => CalendarModel.fromJson(item)).toList()
        : [];
  }

  Future<List<CalendarModel>> getItemsByRange(int start, int end) async {
    final db = await database;
    final result = await db.query(
      'event',
      where: 'millisecond >= ? AND millisecond <= ?',
      whereArgs: [start, end],
    );
    return result.isNotEmpty
        ? result.map((item) => CalendarModel.fromJson(item)).toList()
        : [];
  }

  Future<List<CalendarModel>> getItemsByColor(int color) async {
    final db = await database;
    final result = await db.query(
      'event',
      where: 'color = ?',
      whereArgs: [color],
    );
    return result.isNotEmpty
        ? result.map((item) => CalendarModel.fromJson(item)).toList()
        : [];
  }

  Future<List<CalendarModel>> getItemsByLocation(String location) async {
    final db = await database;
    final result = await db.query(
      'event',
      where: 'location = ?',
      whereArgs: [location],
    );
    return result.isNotEmpty
        ? result.map((item) => CalendarModel.fromJson(item)).toList()
        : [];
  }



  Future<List<CalendarModel>> getItemsByTitle(String title) async {
    final db = await database;
    final result = await db.query(
      'event',
      where: 'title = ?',
      whereArgs: [title],
    );
    return result.isNotEmpty
        ? result.map((item) => CalendarModel.fromJson(item)).toList()
        : [];
  }

  Future<List<CalendarModel>> getItemsByDescription(String description) async {
    final db = await database;
    final result = await db.query(
      'event',
      where: 'description = ?',
      whereArgs: [description],
    );
    return result.isNotEmpty
        ? result.map((item) => CalendarModel.fromJson(item)).toList()
        : [];
  }

  Future<List<CalendarModel>> getItemsByStartTime(int startTime) async {
    final db = await database;
    final result = await db.query(
      'event',
      where: 'startTime = ?',
      whereArgs: [startTime],
    );
    return result.isNotEmpty
        ? result.map((item) => CalendarModel.fromJson(item)).toList()
        : [];
  }

  Future<List<CalendarModel>> getItemsByEndTime(int endTime) async {
    final db = await database;
    final result = await db.query(
      'event',
      where: 'endTime = ?',
      whereArgs: [endTime],
    );
    return result.isNotEmpty
        ? result.map((item) => CalendarModel.fromJson(item)).toList()
        : [];
  }

  Future<List<CalendarModel>> getItemsByMillisecond(int millisecond) async {
    final db = await database;
    final result = await db.query(
      'event',
      where: 'millisecond = ?',
      whereArgs: [millisecond],
    );
    return result.isNotEmpty
        ? result.map((item) => CalendarModel.fromJson(item)).toList()
        : [];
  }

  Future<List<CalendarModel>> getItemsByDayMonthYear(int day, int month, int year) async {
    final db = await database;
    final result = await db.query(
      'event',
      where: 'day = ? AND month = ? AND year = ?',
      whereArgs: [day, month, year],
    );
    return result.isNotEmpty
        ? result.map((item) => CalendarModel.fromJson(item)).toList()
        : [];
  }


}
