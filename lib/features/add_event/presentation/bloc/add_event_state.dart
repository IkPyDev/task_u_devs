part of 'add_event_bloc.dart';

class AddEventState {
  StatusEvent status;
  CalendarModel? calenderModel;
  String? title;
  DateTime? date;
  String? description;

  int? color;
  String? startTime;
  String? endTime;
  String? location;
  StatusTime? statusTime;

  AddEventState(
      {required this.status,
      this.calenderModel,
      this.date,
      this.title,
      this.description,
      this.color,
      this.startTime,
      this.endTime,
      this.location,
      this.statusTime});

  factory AddEventState.initial() => AddEventState(status: StatusEvent.initial, statusTime: StatusTime.initial);

  AddEventState copyWith({
    CalendarModel? calenderModel,
    String? title,
    String? description,
    int? color,
    String? startTime,
    String? endTime,
    String? location,
    StatusEvent? status,
    StatusTime? statusTime,
    DateTime? data,
  }) {
    return AddEventState(
      calenderModel: calenderModel ?? this.calenderModel,
      date: data ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      status: status ?? this.status,
      statusTime: statusTime ?? this.statusTime,
    );
  }
}

enum StatusTime {
  initial,
  startTime,
  endTime,
  finish,
}
