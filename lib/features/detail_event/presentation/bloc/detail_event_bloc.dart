import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_u_devs/shared/domain/model/calender_model.dart';
import 'package:task_u_devs/shared/domain/model/calender_model.dart';
import 'package:task_u_devs/shared/domain/model/status_event.dart';

import '../../../../shared/di/di.dart';
import '../../../../shared/domain/repository/database_repository.dart';
import '../../../calendar/presentation/widgets/calendar_details.dart';

part 'detail_event_event.dart';
part 'detail_event_state.dart';

class DetailEventBloc extends Bloc<DetailEvent, DetailEventState> {
  final repository = di<DatabaseRepository>();

  DetailEventBloc() : super(DetailEventState()) {
    on<DetailLoadEvent>((event, emit) async {
      emit(state.copyWith(status: StatusEvent.loading));
        final calendarModel = await repository.getEvent(event.id);
        if (calendarModel == null) {
          emit(state.copyWith(status: StatusEvent.error));
          return;
        }
        emit(state.copyWith(status: StatusEvent.success, calendarModel: calendarModel));

    });

    on<DetailDeleteEvent>((event, emit) async {
        await repository.deleteEvent(event.id);
        emit(state.copyWith(status: StatusEvent.initial));
    });
  }



}
