import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_u_devs/features/calendar/presentation/widgets/utils.dart';

import '../../../../core/widgets/common_loading.dart';
import '../../../../core/widgets/common_text.dart';
import '../../../../core/widgets/item_day.dart';
import '../../../../shared/domain/model/calender_model.dart';
import '../bloc/calendar_page_bloc.dart';
import '../bloc/calendar_page_event.dart';
import '../bloc/calendar_page_state.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarPageBloc, CalendarPageState>(
      builder: (context, state) {
        String text = '';
        if(state.selectedCalendar != SelectedCalendar.yearly){
          text = "${getMonthName(state.currentDate?.month ?? 9)} ${state.currentDate?.year ?? 2024 }";
        }else{
          text = "${state.currentDate?.year ?? 2024 }";
        }
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const SizedBox( width: 10,),
                CommonText(
                  text: text,
                  padding: 0,
                  textSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                // const SizedBox(width: 10,),
                PopupMenuButton<SelectedCalendar>(

                 icon: const Icon(Icons.menu),
                  onSelected: (SelectedCalendar result) {
                    context.read<CalendarPageBloc>().add(SelectedCalendarEvent(result));
                    context.read<CalendarPageBloc>().add(LoadEventsEvent());
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<SelectedCalendar>>[
                    const PopupMenuItem<SelectedCalendar>(
                      value: SelectedCalendar.yearly,
                      child: CommonText(text: 'Yearly'),
                    ),
                    const PopupMenuItem<SelectedCalendar>(
                      value: SelectedCalendar.monthly,
                      child: CommonText(text: 'Monthly'),
                    ),
                    const PopupMenuItem<SelectedCalendar>(
                      value: SelectedCalendar.weekly,
                      child: CommonText(text: 'Weekly'),
                    ),
                    const PopupMenuItem<SelectedCalendar>(
                      value: SelectedCalendar.daily,
                      child: CommonText(text: 'Daily'),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {

                    context.read<CalendarPageBloc>().add(PreviousMonthCalendarEvent());
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),

                IconButton(
                  onPressed: () {
                    context.read<CalendarPageBloc>().add(NextMonthCalendarEvent());
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                  .map((day) =>
                  Expanded(
                    child: Center(
                      child: CommonText(
                        text: day,
                        padding: 0,
                        textSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
                  .toList(),
            ),
           switch(state.selectedCalendar){
             // TODO: Handle this case.
             SelectedCalendar.yearly => const CalendarYearly(),
             // TODO: Handle this case.
             SelectedCalendar.monthly => const CalendarMothly(),
             // TODO: Handle this case.
             SelectedCalendar.weekly => const CalendarWeekly(),
             // TODO: Handle this case.
             SelectedCalendar.daily => const CalendarDay(),
           },

          ],
        );
      },
    );
  }
}

class CalendarMothly extends StatefulWidget {
  const CalendarMothly({super.key});

  @override
  State<CalendarMothly> createState() => _CalendarMothlyState();
}

class _CalendarMothlyState extends State<CalendarMothly> {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CalendarPageBloc, CalendarPageState>(
      builder: (context, state) {


        if(state.status == Status.success){
          int daysInMonth = DateTime(state.currentDate?.year ??DateTime.now().year,state.currentDate?.month ?? DateTime.now().year + 1, 0).day;

          int firstWeekdayOfMonth = DateTime(state.currentDate?.year ?? DateTime.now().year, state.currentDate?.month ?? DateTime.now().day, 1).weekday;

          List<Widget> dayWidgets = [];

          for (int i = 1; i < firstWeekdayOfMonth; i++) {
            dayWidgets.add(Container());
          }

          for (int day = 1; day <= daysInMonth; day++) {

            List<CalendarModel> eventsOfDay = state.events?[day] ?? [];

            // Voqealarning ranglarini olish
            List<int> colors = eventsOfDay.map((event) => event.color ?? 0xFF000000).toList();
            dayWidgets.add(
              ItemDay(
                title: day.toString(),
                colors: colors,
                onTap: (isSelected) {
                  print(isSelected);
                  if(!isSelected){
                    context.read<CalendarPageBloc>().add(SelectedDayEvent(day));
                  }else{
                    context.read<CalendarPageBloc>().add(SelectedDayEvent(-1));
                  }
                  setState(() {

                  });
                },
                isSelect: day == state.selectedDay,
              ),
            );
          }

          return SizedBox(
            height:MediaQuery.of(context).size.height * 0.4,
            child: GridView.count(
              crossAxisCount: 7,
              padding: EdgeInsets.zero,
              children: dayWidgets,
            ),
          );

        }else{
          return const CommonLoading();
        }

      },
    );
  }
}

class CalendarWeekly extends StatefulWidget {
  const CalendarWeekly({super.key});

  @override
  State<CalendarWeekly> createState() => _CalendarWeeklyState();
}

class _CalendarWeeklyState extends State<CalendarWeekly> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarPageBloc, CalendarPageState>(
      builder: (context, state) {
        if (state.status == Status.success) {
          List<Widget> weekDays = [];

          // Haftaning kunlarini to'ldirish
          for (int i = 0; i < 7; i++) {
            DateTime currentDay = state.currentDate!.add(Duration(days: i - state.currentDate!.weekday + 1));
            List<CalendarModel> eventsOfDay = state.events?[currentDay.day] ?? [];
            List<int> colors = eventsOfDay.map((event) => event.color ?? 0xFF000000).toList();

            weekDays.add(
              ItemDay(
                title: currentDay.day.toString(),
                colors: colors,
                onTap: (isSelected) {
                  if (!isSelected) {
                    context.read<CalendarPageBloc>().add(SelectedDayEvent(currentDay.day));
                  } else {
                    context.read<CalendarPageBloc>().add(SelectedDayEvent(-1));
                  }
                  setState(() {
                  });

                },
                isSelect: currentDay.day == state.selectedDay,
              ),
            );
          }

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: GridView.count(
              crossAxisCount: 7,
              padding: EdgeInsets.zero,
              children: weekDays,
            ),
          );
        } else {

          return  CommonLoading(height:( MediaQuery.of(context).size.height * 0.2),);
        }
      },
    );
  }
}

class CalendarDay extends StatelessWidget {
  const CalendarDay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarPageBloc, CalendarPageState>(
      builder: (context, state) {
        if (state.status == Status.success) {
          DateTime currentDay = state.currentDate!;
          List<CalendarModel> eventsOfDay = state.events?[currentDay.day] ?? [];
          List<int> colors = eventsOfDay.map((event) => event.color ?? 0xFF000000).toList();

          return Column(
            children: [

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: ItemDay(
                  title: currentDay.day.toString(),
                  colors: colors,
                  onTap: (isSelected) {
                    if (!isSelected) {
                      context.read<CalendarPageBloc>().add(SelectedDayEvent(currentDay.day));
                    } else {
                      context.read<CalendarPageBloc>().add(SelectedDayEvent(-1));
                    }
                  },
                  isSelect: currentDay.day == state.selectedDay,
                ),
              ),
            ],
          );
        } else {
          return  CommonLoading( height: MediaQuery.of(context).size.height * 0.2,);
        }
      },
    );
  }
}

class CalendarYearly extends StatelessWidget {
  const CalendarYearly({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarPageBloc, CalendarPageState>(
      builder: (context, state) {
        if (state.status == Status.success) {
          // Oyliklarni yilda ko'rsatish
          List<Widget> monthWidgets = List.generate(12, (index) {
            DateTime firstDayOfMonth = DateTime(state.currentDate!.year, index + 1, 1);
            return GestureDetector(
              onTap: () {
                context.read<CalendarPageBloc>().add(SelectedDateEvent(firstDayOfMonth));
                context.read<CalendarPageBloc>().add(SelectedCalendarEvent(SelectedCalendar.monthly));
                context.read<CalendarPageBloc>().add(LoadEventsEvent());
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: CommonText(
                    text: getMonthName(index + 1),
                    padding: 0,
                    textSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          });

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 1,
              padding: EdgeInsets.all(1),
              children: monthWidgets,
            ),
          );
        } else {
          return const CommonLoading();
        }
      },
    );
  }
}



