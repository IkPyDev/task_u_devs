part of 'detail_event_bloc.dart';

class DetailEventState extends Equatable {

  CalendarModel? calendarModel;
  StatusEvent status;

  DetailEventState({
    this.calendarModel,
    this.status = StatusEvent.loading,
  });


  DetailEventState copyWith({
    CalendarModel? calendarModel,
    StatusEvent? status,
  }) {
    return DetailEventState(
      status: status ?? this.status,
      calendarModel: calendarModel ?? this.calendarModel,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [calendarModel, status];

}


