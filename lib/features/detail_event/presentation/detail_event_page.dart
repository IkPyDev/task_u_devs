import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_u_devs/core/extension/color.dart';
import 'package:task_u_devs/core/extension/string.dart';
import 'package:task_u_devs/core/widgets/common_scaffold.dart';
import 'package:task_u_devs/core/widgets/common_text.dart';
import 'package:task_u_devs/core/widgets/common_text_icon_button.dart';
import 'package:task_u_devs/features/calendar/presentation/bloc/calendar_page_bloc.dart';
import 'package:task_u_devs/features/calendar/presentation/bloc/calendar_page_event.dart';
import 'package:task_u_devs/shared/domain/model/calender_model.dart';

import '../../../shared/domain/model/status_event.dart';
import '../../add_event/presentation/add_event_page.dart';
import '../../add_event/presentation/bloc/add_event_bloc.dart';
import 'bloc/detail_event_bloc.dart';

class DetailEventPage extends StatelessWidget {
  const DetailEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailEventBloc, DetailEventState>(
  builder: (context, state) {
    switch (state.status) {
      case StatusEvent.initial:
        Navigator.pop(context,true);
        return const SizedBox();
      case StatusEvent.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case StatusEvent.error:
        return  Scaffold(
          appBar: AppBar(
            backgroundColor: context.colors.redSelect,

          ),
          body: Center(
            child: CommonText(
              text: "Error",
              textSize: 18,
              color: context.colors.redSelect,
            ),
          ),
        );
      case StatusEvent.success:
        return _buildDetail(context, state.calendarModel);
      default:
        return const SizedBox();
    }

  },
);
  }

  Widget _buildDetail(BuildContext context, CalendarModel? calendarModel) {
    final valueColor = calendarModel?.color ?? 0;
    final Color color =Color(valueColor);
    return CommonScaffold(
      body: Stack(
        children:[ Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(6),
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: context.colors.onPrimary),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: color,
                              size: 20,
                            ),
                            onPressed: () {

                              context.read<CalendarPageBloc>().add(LoadEventsEvent());
                              Navigator.pop(context,null);
                            },
                          ),
                        ),
                        const Spacer(),
                        CommonTextIconButton(
                          title: "Edit",
                          iconData: Icons.edit_note_outlined,
                          color: context.colors.onTextPrimary,
                          backgroundColor: color.withOpacity(0),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => BlocProvider(
                                          create: (context) => AddEventBloc()..add(EditScreenEvent(calendarModel: calendarModel!)),
                                          child: const AddEventPage(
                                          ),
                                        ),),).then((value) {
                              context.read<CalendarPageBloc>().add(LoadEventsEvent());

                              context.read<DetailEventBloc>().add(DetailLoadEvent(calendarModel?.id ?? 0));
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CommonText(
                      text: calendarModel?.title?? "",
                      textSize: 28,
                      color: context.colors.onTextPrimary,

                      padding: 0,
                    ),
                    CommonText(
                      text: calendarModel?.description?.getFirstSentence()  ?? "",
                      textSize: 12,
                      color: context.colors.onTextPrimary,
                      padding: 0,

                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CommonTextIconButton(
                      title: "${ calendarModel?.startTime} - ${calendarModel?.endTime}",
                      color: context.colors.onTextPrimary,
                      backgroundColor: color.withOpacity(0),

                      iconData: Icons.timer_rounded,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if(calendarModel?.location != null)
                      CommonTextIconButton(
                      title: calendarModel?.location ?? "",
                      color: context.colors.onTextPrimary,
                        backgroundColor: color.withOpacity(0),

                      iconData: Icons.location_on,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )),
            Container(
              margin: const EdgeInsets.only( left: 25, right: 25),
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CommonText(
                    text: "Reminder",
                    textSize: 18,
                    color: context.colors.systemBlack,
                    padding: 0,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonText(
                    text: calendarModel?.millisecond.timeAgo() ?? "Time error ",
                    textSize: 12,
                    color: context.colors.systemGrey2,
                    padding: 0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonText(
                    text: "Description",
                    textSize: 18,
                    color: context.colors.systemBlack,
                    padding: 0,
                    fontWeight: FontWeight.bold,
                  ),
                  CommonText(
                    text:calendarModel?.description ?? "",
                    textSize: 12,
                    color: context.colors.systemGrey2,
                    padding: 0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),


                ],
              ),
            )
          ],
        ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child:GestureDetector(
              onTap: () {
                context.read<DetailEventBloc>().add(DetailDeleteEvent(calendarModel?.id ?? 0));
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 32,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: context.colors.redSelect.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: context.colors.systemGrey, blurRadius: 10, offset: const Offset(0, 5))]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete,
                      color: context.colors.redSelect,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CommonText(
                      text: "Delete",
                      textSize: 18,
                      color: context.colors.systemBlack,
                      padding: 0,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
          )],
      ),
    );
  }

}
