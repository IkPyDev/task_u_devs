import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_u_devs/core/extension/color.dart';
import 'package:task_u_devs/core/widgets/common_scaffold.dart';
import 'package:task_u_devs/core/widgets/common_text.dart';
import 'package:task_u_devs/features/add_event/presentation/add_event_page.dart';
import 'package:task_u_devs/features/add_event/presentation/bloc/add_event_bloc.dart';
import 'package:task_u_devs/features/calendar/presentation/bloc/calendar_page_event.dart';
import 'package:task_u_devs/features/calendar/presentation/widgets/calendar.dart';
import 'package:task_u_devs/features/calendar/presentation/widgets/calendar_details.dart';
import 'package:task_u_devs/features/calendar/presentation/widgets/utils.dart';
import 'bloc/calendar_page_bloc.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});


  @override
  Widget build(BuildContext context) {
    final dataTime = DateTime.now();
    return CommonScaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title:  Column(
          children: [
            CommonText(
              text: getMonthName(dataTime.weekday),
              padding: 0,
              fontWeight: FontWeight.bold,
              textSize: 22,
            ),
            CommonText(
              text: '${dataTime.day} ${getMonthName(dataTime.month)} ${dataTime.year}',
              padding: 0,
              textSize: 12,
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: CommonText(
                        text: 'Notification not available',
                        padding: 0,
                        textSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.notifications_sharp,
                  color: context.colors.systemBlack,
                  size: 28,
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: context.colors.onPrimary, width: 1),
                    color: context.colors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const Calendar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CommonText(
                  text: 'Schedule',
                  padding: 0,
                  textSize: 21,
                  fontWeight: FontWeight.bold,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => BlocProvider(
                                  create: (context) => AddEventBloc(),
                                  child: const AddEventPage(),
                                ),),) .then((value) {
                                  if(value != null){
                                    print("XXXXXXXXXXXXXXX");
                                    print(value);
                                    context.read<CalendarPageBloc>().add(LoadEventsEvent());
                                  }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    decoration: BoxDecoration(color: context.colors.primary, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_circle_outlined,
                          color: context.colors.onPrimary,
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        CommonText(
                          text: 'Add Event',
                          padding: 5,
                          color: context.colors.onPrimary,
                          textSize: 15,
                          // backgroundColor: context.colors.primary,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const CalendarDetails(),
          ],
        ),
      ),
    );
  }
}

