import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../../shared/di/di.dart';
import '../../../../shared/domain/model/calender_model.dart';
import '../../../../shared/domain/repository/database_repository.dart';
import 'calendar_page_event.dart';
import 'calendar_page_state.dart';

class CalendarPageBloc extends Bloc<CalendarPageEvent, CalendarPageState> {
  final DatabaseRepository repository;

  CalendarPageBloc() : repository = di<DatabaseRepository>(), super(CalendarPageState()) {
    on<LoadEventsEvent>(_onLoadEvents);
    on<NextMonthCalendarEvent>(_onNextPeriod);
    on<PreviousMonthCalendarEvent>(_onPreviousPeriod);
    on<SelectedDayEvent>(_onSelectedDay);
    on<SelectedCalendarEvent>(_onSelectedCalendar);
    on<SelectedDateEvent>(_onSelectedDate);
    // on<SelectedDayOpenEvent>(_onSelectedDayOpen);
  }

  // Ma'lumotlarni yuklash
  Future<void> _onLoadEvents(LoadEventsEvent event, Emitter<CalendarPageState> emit) async {
    emit(state.copyWith(status: Status.loading, events: {}));
    final DateTime currentDate = state.currentDate ?? DateTime.now();
    final int daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;

    final int startOfMonth = DateTime(currentDate.year, currentDate.month, 1).millisecondsSinceEpoch;
    final int endOfMonth =
        DateTime(currentDate.year, currentDate.month, daysInMonth, 23, 59, 59).millisecondsSinceEpoch;

    if(state.selectList.isNotEmpty){
      final List<CalendarModel> selectedEvents = await repository.getEventsByDay(
        state.selectList[0].day!,
        state.selectList[0].month!,
        state.selectList[0].year!,

      );
      emit(state.copyWith(selectList: selectedEvents));
    }
    try {
      final List<CalendarModel> events = await repository.getEventsByRange(startOfMonth, endOfMonth);
      final Map<int, List<CalendarModel>> eventsByDay = {};

      for (var event in events) {
        final int day = event.day ?? 0;
        if (eventsByDay.containsKey(day)) {
          eventsByDay[day]!.add(event);
        } else {
          eventsByDay[day] = [event];
        }
      }
      emit(state.copyWith(events: eventsByDay, status: Status.success, currentDate: currentDate));
    } catch (error) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  // Keyingi periodning ma'lumotlarini yuklash
  Future<void> _onNextPeriod(NextMonthCalendarEvent event, Emitter<CalendarPageState> emit) async {
    final DateTime currentDate = state.currentDate ?? DateTime.now();
    DateTime nextPeriod;
    emit(state.copyWith(status: Status.loading, selectList: [], selectedDay: -1));


    switch (state.selectedCalendar) {

      case SelectedCalendar.daily:
        nextPeriod = currentDate.add(Duration(days: 1));
        break;
      case SelectedCalendar.weekly:
        nextPeriod = currentDate.add(Duration(days: 7));
        break;
      case SelectedCalendar.monthly:
        nextPeriod = DateTime(currentDate.year, currentDate.month + 1);
        break;
      case SelectedCalendar.yearly:
        nextPeriod = DateTime(currentDate.year + 1, currentDate.month);
        break;
    }

    await _loadEventsForPeriod(nextPeriod, emit);
  }

  // Oldingi periodning ma'lumotlarini yuklash
  Future<void> _onPreviousPeriod(PreviousMonthCalendarEvent event, Emitter<CalendarPageState> emit) async {
    final DateTime currentDate = state.currentDate ?? DateTime.now();
    DateTime previousPeriod;
    emit(state.copyWith(status: Status.loading, selectList: [], selectedDay: -1));

    switch (state.selectedCalendar) {
      case SelectedCalendar.daily:
        previousPeriod = currentDate.subtract(Duration(days: 1));
        break;
      case SelectedCalendar.weekly:
        previousPeriod = currentDate.subtract(Duration(days: 7));
        break;
      case SelectedCalendar.monthly:
        previousPeriod = DateTime(currentDate.year, currentDate.month - 1);
        break;
      case SelectedCalendar.yearly:
        previousPeriod = DateTime(currentDate.year - 1, currentDate.month);
        break;
    }

    await _loadEventsForPeriod(previousPeriod, emit);
  }

  // Periodga mos keluvchi hodisalarni yuklash
  Future<void> _loadEventsForPeriod(DateTime period, Emitter<CalendarPageState> emit) async {
    emit(state.copyWith(status: Status.loading, events: {}));

    final DateTime startOfPeriod;
    final DateTime endOfPeriod;

    switch (state.selectedCalendar) {
      case SelectedCalendar.daily:
        startOfPeriod = DateTime(period.year, period.month, period.day);
        endOfPeriod = DateTime(period.year, period.month, period.day, 23, 59, 59);
        break;
      case SelectedCalendar.weekly:
        startOfPeriod = period.subtract(Duration(days: period.weekday - 1)); // Hafta boshini aniqlash
        endOfPeriod = startOfPeriod.add(Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
        break;
      case SelectedCalendar.monthly:
        final int daysInMonth = DateTime(period.year, period.month + 1, 0).day;
        startOfPeriod = DateTime(period.year, period.month, 1);
        endOfPeriod = DateTime(period.year, period.month, daysInMonth, 23, 59, 59);
        break;
      case SelectedCalendar.yearly:
        startOfPeriod = DateTime(period.year, 1, 1);
        endOfPeriod = DateTime(period.year, 12, 31, 23, 59, 59);
        break;
    }

    try {
      final List<CalendarModel> events = await repository.getEventsByRange(
        startOfPeriod.millisecondsSinceEpoch,
        endOfPeriod.millisecondsSinceEpoch,
      );

      final Map<int, List<CalendarModel>> eventsByDay = {};

      for (var event in events) {
        final int day = event.day ?? 0;
        if (eventsByDay.containsKey(day)) {
          eventsByDay[day]!.add(event);
        } else {
          eventsByDay[day] = [event];
        }
      }

      emit(state.copyWith(events: eventsByDay, status: Status.success, currentDate: period));
    } catch (error) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  // Tanlangan kunning ma'lumotlarini yuklash
  Future<void> _onSelectedDay(SelectedDayEvent event, Emitter<CalendarPageState> emit) async {
    final List<CalendarModel> selectedEvents = await repository.getEventsByDay(
      event.day,
      state.currentDate!.month,
      state.currentDate!.year,
    );
    emit(state.copyWith(selectList: selectedEvents, selectedDay: event.day));
  }

  // Kalendar turini tanlash
  void _onSelectedCalendar(SelectedCalendarEvent event, Emitter<CalendarPageState> emit) {
    emit(state.copyWith(selectedCalendar: event.selectedCalendar, selectList: [], selectedDay: -1));
  }

  FutureOr<void> _onSelectedDate(SelectedDateEvent event, Emitter<CalendarPageState> emit) {
    emit(state.copyWith(currentDate: event.date));
  }

  FutureOr<void> _onSelectedDayOpen(SelectedDayOpenEvent event, Emitter<CalendarPageState> emit) {

  }
}
