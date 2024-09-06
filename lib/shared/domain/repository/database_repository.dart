
import 'package:task_u_devs/shared/domain/model/calender_model.dart';

abstract class DatabaseRepository {

  addEvent(CalendarModel event);

  updateEvent(int id, CalendarModel event);

  deleteEvent(int id);

  // Future<List<CalendarModel>> getEvents();

  Future<CalendarModel?> getEvent(int id);

  Future<List<CalendarModel>> getEventsByDay(int day, int month, int year);

  Future<List<CalendarModel>> getEventsByMonth(int month, int year);

  Future<List<CalendarModel>> getEventsByYear(int year);

  Future<List<CalendarModel>> getEventsByRange(int start, int end);
}