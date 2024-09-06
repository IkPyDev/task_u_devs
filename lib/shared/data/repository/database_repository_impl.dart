
import 'package:task_u_devs/shared/domain/model/calender_model.dart';

import '../../domain/repository/database_repository.dart';
import '../src/database_helper.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseRepositoryImpl(this.databaseHelper);

  final DatabaseHelper databaseHelper;



  @override
  addEvent(CalendarModel event) async {

    await databaseHelper.addItem(event);

  }

  @override
  deleteEvent(int id) async {

    await databaseHelper.deleteItem(id);
    // TODO: implement deleteEvent
    // throw UnimplementedError();
  }

  @override
  Future<CalendarModel?> getEvent(int id) {

    return databaseHelper.getItemById(id);
    // TODO: implement getEvent
    throw UnimplementedError();
  }

  // @override
  // Future<List<CalendarModel>> getEvents() {
  //   // TODO: implement getEvents
  //   throw UnimplementedError();
  // }

  @override
  Future<List<CalendarModel>> getEventsByDay(int day, int month, int year) {

    return databaseHelper.getItemsByDay(day, month, year);
    // TODO: implement getEventsByDay
    throw UnimplementedError();
  }

  @override
  Future<List<CalendarModel>> getEventsByMonth(int month, int year) {

    return databaseHelper.getItemsByMonth(month, year);

    // TODO: implement getEventsByMonth
    throw UnimplementedError();
  }

  @override
  Future<List<CalendarModel>> getEventsByRange(int start, int end) {

    return databaseHelper.getItemsByRange(start, end);
    // TODO: implement getEventsByRange
    throw UnimplementedError();
  }

  @override
  Future<List<CalendarModel>> getEventsByYear(int year) {
    // TODO: implement getEventsByYear

    return databaseHelper.getItemsByYear(year);
    throw UnimplementedError();
  }

  @override
  updateEvent(int id, CalendarModel event) {
    // TODO: implement updateEvent

    return databaseHelper.updateItem(id, event);
    throw UnimplementedError();
  }




}