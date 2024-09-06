part of 'add_event_bloc.dart';

abstract class AddEventEvent {}

final class AddTitleEvent extends AddEventEvent{
  final String title;
  AddTitleEvent({required this.title});
}

final class AddDescriptionEvent extends AddEventEvent{
  final String description;
  AddDescriptionEvent({required this.description});
}

final class AddColorEvent extends AddEventEvent{
  final int color;
  AddColorEvent({required this.color});
}

final class AddStartTimeEvent extends AddEventEvent{
  final String startTime;
  final DateTime date;
  AddStartTimeEvent({required this.startTime,required this.date});
}

final class AddEndTimeEvent extends AddEventEvent{
  final String endTime;
  AddEndTimeEvent({required this.endTime});
}

final class AddLocationEvent extends AddEventEvent{
  final String location;
  AddLocationEvent({required this.location});
}

final class SaveButtonEvent extends AddEventEvent{}

final class EditScreenEvent extends AddEventEvent{
  final CalendarModel calendarModel;
  EditScreenEvent({required this.calendarModel});
}

final class TimeEvent extends AddEventEvent{}
final class TimeErrorEvent extends AddEventEvent{}




