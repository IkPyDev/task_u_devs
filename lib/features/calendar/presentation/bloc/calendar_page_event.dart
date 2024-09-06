import 'package:equatable/equatable.dart';
import 'package:task_u_devs/features/calendar/presentation/widgets/calendar_details.dart';

import 'calendar_page_bloc.dart';
import 'calendar_page_state.dart';

abstract class CalendarPageEvent extends Equatable {
  const CalendarPageEvent();

  @override
  List<Object?> get props => [];
}

class SelectedCalendarEvent extends CalendarPageEvent {
  final SelectedCalendar selectedCalendar;

  const SelectedCalendarEvent(this.selectedCalendar);

  @override
  List<Object?> get props => [selectedCalendar];
}

class PreviousMonthCalendarEvent extends CalendarPageEvent {}

class NextMonthCalendarEvent extends CalendarPageEvent {}

class SelectedDayEvent extends CalendarPageEvent {
  final int day;

  const SelectedDayEvent(this.day);

  @override
  List<Object?> get props => [day];
}

class LoadEventsEvent extends CalendarPageEvent {}

class SelectedDateEvent extends CalendarPageEvent {
  final DateTime date;

  const SelectedDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class SelectedDayOpenEvent extends CalendarPageEvent {
  final int id;

  const SelectedDayOpenEvent(this.id);

  @override
  List<Object?> get props => [id];
}
