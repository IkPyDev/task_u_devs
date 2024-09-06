
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:task_u_devs/shared/domain/model/calender_model.dart';
import 'package:task_u_devs/shared/domain/model/status_event.dart';

import '../../../../shared/di/di.dart';
import '../../../../shared/domain/repository/database_repository.dart';

part 'add_event_event.dart';
part 'add_event_state.dart';

class AddEventBloc extends Bloc<AddEventEvent, AddEventState> {
  AddEventBloc() : super(AddEventState.initial()) {
    final repository = di<DatabaseRepository>();

    on<AddTitleEvent>((event, emit) {
      emit(state.copyWith(title: event.title));
    });

    on<AddDescriptionEvent>((event, emit) {
      emit(state.copyWith(description: event.description));
    });

    on<AddColorEvent>((event, emit) {
      emit(state.copyWith(color: event.color));
    });

    on<TimeErrorEvent>((event, emit) {
      emit(state.copyWith(statusTime: StatusTime.initial));
    });

    on<TimeEvent>((event, emit) {
      emit(state.copyWith(statusTime: StatusTime.startTime));
    });

    on<EditScreenEvent>((event, emit) {
      emit(state.copyWith(
        calenderModel: event.calendarModel,
        title: event.calendarModel.title,
        description: event.calendarModel.description,
        color: event.calendarModel.color,
        startTime: event.calendarModel.startTime,
        endTime: event.calendarModel.endTime,
        location: event.calendarModel.location,
        statusTime: StatusTime.finish,
      ));
    });

    on<AddStartTimeEvent>((event, emit) {

      emit(state.copyWith(startTime: event.startTime,statusTime: StatusTime.endTime,data: event.date));
    });

    on<AddEndTimeEvent>((event, emit) {
      if (kDebugMode) {
        print(event);
      }
      emit(state.copyWith(endTime: event.endTime,statusTime: StatusTime.finish));
    });

    on<AddLocationEvent>((event, emit) {
      emit(state.copyWith(location: event.location));
    });

    on<SaveButtonEvent>((event, emit) {
      emit(state.copyWith(status: StatusEvent.loading));

      if(state.title == null || state.description == null  || state.startTime == null || state.endTime == null ) {
        emit(state.copyWith(status: StatusEvent.error));
        return;
      }
      if(state.calenderModel != null) {
        final event = CalendarModel(
          id: state.calenderModel?.id ??0,
          title: state.title,
          description: state.description,
          color: state.color,
          startTime: state.startTime,
          endTime: state.endTime,
          location: state.location,
          day: state.calenderModel?.day ??0,
          month: state.calenderModel?.month ??0,
          year: state.calenderModel?.year ??0,
          millisecond: state.calenderModel?.millisecond ??0,
        );
        try {
          repository.updateEvent(event.id!,event);
          emit(state.copyWith(status: StatusEvent.success));
        } catch (e) {
          emit(state.copyWith(status: StatusEvent.error));
        }
        return;
      }
      final event = CalendarModel(
        title: state.title,
        description: state.description,
        color: state.color,
        startTime: state.startTime,
        endTime: state.endTime,
        location: state.location,
        millisecond: state.date?.millisecondsSinceEpoch ?? DateTime.now().microsecondsSinceEpoch,
        day: state.date?.day,
        month: (state.date?.month??0 +1),
        year: state.date?.year,

      );
      if (kDebugMode) {
        print("DDDDDDDDDDDDDDDDDDDDDDD");
        print(event.toJson());
      }

      try {
        repository.addEvent(event);
        emit(state.copyWith(status: StatusEvent.success));

      } catch (e) {
        emit(state.copyWith(status: StatusEvent.error,));
      }
    });
  }
}
