import 'package:equatable/equatable.dart';

import '../../../../shared/domain/model/calender_model.dart';

enum SelectedCalendar { daily, weekly, monthly, yearly }

enum Status { initial, loading, success, failure }

class CalendarPageState extends Equatable {
   DateTime? currentDate;
   int selectedDay;
   SelectedCalendar selectedCalendar;
   Map<int, List<CalendarModel>>? events;
   Status status;
   List<CalendarModel> selectList = [];


   CalendarPageState({
    this.currentDate,
    this.selectedDay = -1,
    this.selectedCalendar = SelectedCalendar.monthly,
    this.events,
    this.status = Status.initial,
     this.selectList =const [],
  });

  CalendarPageState copyWith({
    DateTime? currentDate,
    int? selectedDay,
    SelectedCalendar? selectedCalendar,
    Map<int, List<CalendarModel>>? events,
    Status? status,
    List<CalendarModel>? selectList,
  }) {
    return CalendarPageState(
      currentDate: currentDate ?? this.currentDate,
      selectedDay: selectedDay ?? this.selectedDay,
      selectedCalendar: selectedCalendar ?? this.selectedCalendar,
      events: events ?? this.events,
      status: status ?? this.status,
      selectList: selectList ?? this.selectList,
    );
  }

  @override
  List<Object?> get props => [currentDate, selectedDay, selectedCalendar, events, status];
}






