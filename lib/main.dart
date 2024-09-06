import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_u_devs/core/extension/color.dart';
import 'package:task_u_devs/core/widgets/common_text.dart';
import 'package:task_u_devs/features/calendar/presentation/bloc/calendar_page_bloc.dart';
import 'package:task_u_devs/features/calendar/presentation/calendar_page.dart';
import 'package:task_u_devs/shared/di/di.dart';

import 'core/widgets/item_day.dart';
import 'features/calendar/presentation/bloc/calendar_page_event.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CalendarPageBloc>(
          create: (context) => CalendarPageBloc()..add(LoadEventsEvent()),
        ),
      ],
  child: MaterialApp(
      title: 'Event Calendar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: context.colors.primary,
          onSurface: context.colors.onPrimary,
          background: context.colors.onPrimary,
        ),
        useMaterial3: true,


      ),
      debugShowCheckedModeBanner: false,
      home:  BlocProvider(
  create: (context) => CalendarPageBloc()..add(LoadEventsEvent()),
  child: CalendarPage(),
),
    ),
);
  }
}


class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _currentDate = DateTime.now();
  String _selectedView = 'Monthly';

  int selectedDay =-1;

  // Methods for handling month navigation
  void _previousMonth() {
    setState(() {
      selectedDay =-1;
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      selectedDay =-1;
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
    });
  }

  // Method for building the days in a month
  List<Widget> _buildDaysInMonth() {
    int daysInMonth = DateTime(_currentDate.year, _currentDate.month + 1, 0).day;
    int firstWeekdayOfMonth = DateTime(_currentDate.year, _currentDate.month, 1).weekday;
    List<Widget> dayWidgets = [];

    // Empty spaces for days from the previous month
    for (int i = 1; i < firstWeekdayOfMonth; i++) {
      dayWidgets.add(Container());
    }

    // Actual days in the month
    for (int day = 1; day <= daysInMonth; day++) {
      dayWidgets.add(ItemDay(
        title: day.toString(),
        colors: [0xFF42A5F5, 0xFFEF5350, 0xFF66BB6A, 0xFFFFA726,0xFF66BB6A], // Example colors
        onTap: (isSelected) {
          selectedDay =day == selectedDay ? -1 : day;
          setState(() {

          });
        },
        isSelect: day == selectedDay,
      ));
    }

    return dayWidgets;
  }

  // Method for building the entire calendar
  Widget _buildCalendar() {
    switch (_selectedView) {
      case 'Yearly':
        return _buildYearView();
      case 'Weekly':
        return _buildWeekView();
      case 'Daily':
        return _buildDayView();
      default:
        return _buildMonthView();
    }
  }

  // Method to build the Month View
  Widget _buildMonthView() {
    return Column(
      children: [
        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
              .map((day) => Expanded(
              child: Center(
                  child: CommonText(
                    text: day, fontWeight: FontWeight.bold,
                  ))))
              .toList(),
        ),
        // Days grid
        Expanded(
          child: GridView.count(
            crossAxisCount: 7,
            padding: EdgeInsets.zero,
            children: _buildDaysInMonth(),
          ),
        ),
      ],
    );
  }

  // Method to build the Year View
  Widget _buildYearView() {
    return GridView.builder(
      itemCount: 12,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return Card(
          child: Center(
            child: CommonText(
              text:_getMonthName(index + 1),
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  // Method to build the Week View
  Widget _buildWeekView() {
    DateTime firstDayOfWeek = _currentDate.subtract(Duration(days: _currentDate.weekday - 1));
    List<Widget> dayWidgets = [];


    for (int i = 0; i < 7; i++) {
      dayWidgets.add(ItemDay(
        height: 40,
        width: 40,
        title: (firstDayOfWeek.add(Duration(days: i)).day).toString(),
        colors: [0xFF42A5F5, 0xFFEF5350, 0xFF66BB6A, 0xFFFFA726], // Example colors
        onTap: (isSelected) {
          // Action on day tap
        },
        isSelect: false,
      ));
    }

    return Column(
      children: [
        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
              .map((day) => Expanded(
              child: Center(
                  child: CommonText(
                    text: day,
                    fontWeight: FontWeight.bold,
                  ),),),)
              .toList(),
        ),
        // Days in week
        Expanded(
          child: GridView.count(
            crossAxisCount: 7,
            children: dayWidgets,
          ),
        ),
      ],
    );
  }

  // Method to build the Day View
  Widget _buildDayView() {
    return Center(
      child: ItemDay(
        height: 150,
        width: 150,
        title: _currentDate.day.toString(),
        colors: const [0xFF42A5F5, 0xFFEF5350, 0xFF66BB6A, 0xFFFFA726], // Example colors
        onTap: (isSelected) {

        },
        isSelect: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(text: 'Event Calendar'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              setState(() {
                _selectedView = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Yearly',
                child: CommonText(text: 'Yearly'),
              ),
              const PopupMenuItem<String>(
                value: 'Monthly',
                child: CommonText(text: 'Monthly'),
              ),
              const PopupMenuItem<String>(
                value: 'Weekly',
                child: CommonText(text: 'Weekly'),
              ),
              const PopupMenuItem<String>(
                value: 'Daily',
                child: CommonText(text: 'Daily'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Month name and navigation buttons
          if (_selectedView == 'Monthly' || _selectedView == 'Weekly')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: '${_currentDate.year}, ${_getMonthName(_currentDate.month)}',
                   fontWeight: FontWeight.bold,
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.chevron_left,color: context.colors.systemBlack,),
                  onPressed: _previousMonth,
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right,color: context.colors.systemBlack),
                  onPressed: _nextMonth,
                ),
              ],
            ),
          // Calendar display
          Expanded(
            child: _buildCalendar(),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    List<String> monthNames = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return monthNames[month - 1];
  }
}




