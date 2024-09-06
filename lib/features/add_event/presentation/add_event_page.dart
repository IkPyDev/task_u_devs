import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_u_devs/core/extension/color.dart';
import 'package:task_u_devs/core/widgets/common_scaffold.dart';
import 'package:task_u_devs/core/widgets/common_text.dart';
import 'package:task_u_devs/core/widgets/common_text_field.dart';
import 'package:task_u_devs/shared/domain/model/status_event.dart';

import '../../calendar/presentation/bloc/calendar_page_bloc.dart';
import '../../calendar/presentation/bloc/calendar_page_event.dart';
import 'bloc/add_event_bloc.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  static List<Color> colors = [];
  int? isSelect;

  final timeController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  onDispose() {
    timeController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
  }






  @override
  Widget build(BuildContext context) {
    if (colors.isEmpty) {
      colors = [
        context.colors.redSelect,
        context.colors.blueSelect,
        context.colors.greenSelect,
        context.colors.yellowSelect,
        context.colors.purpleSelect,
        context.colors.pinkSelect,
        context.colors.orangeSelect,
      ];
      isSelect = colors[0].value;
    }

    return BlocConsumer<AddEventBloc, AddEventState>(
      listener: (context, state) {
        state.color = isSelect;
        if(state.calenderModel != null){
          isSelect = state.calenderModel?.color;
          titleController.text = state.calenderModel?.title ?? "";
          descriptionController.text = state.calenderModel?.description ?? "";
          locationController.text = state.calenderModel?.location ?? "";
          timeController.text = "${state.calenderModel?.startTime} - ${state.calenderModel?.endTime}";
        }
        titleController.text = state.title ?? "";
        descriptionController.text = state.description ?? "";
        locationController.text = state.location ?? "";


        switch(state.status){
          case StatusEvent.initial:
            break;
          case StatusEvent.loading:

            break;
          case StatusEvent.success:
            Navigator.pop(context,true);
            break;
          case StatusEvent.error:

            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                content: CommonText(text: 'Check the headspace',color: context.colors.onPrimary,),
              ),
            );
            state.status = StatusEvent.initial;
            break;
        }

        switch (state.statusTime) {
          case null:
            break;
          case StatusTime.initial:
            break;
          case StatusTime.startTime:
            FocusScope.of(context).unfocus();
            var formattedTime;
            var formattedDate;
            showCupertinoModalPopup(

              context: context,
              builder: (_) => Container(
                height: MediaQuery.of(context).size.height * 0.3,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.dateAndTime,
                        initialDateTime: DateTime.now(),
                        use24hFormat: true,
                        onDateTimeChanged: (DateTime value) {
                          formattedDate = value;
                          formattedTime = TimeOfDay(
                            hour: value.hour,
                            minute: value.minute,
                          ).format(context);
                        },
                      ),
                    ),
                    CupertinoButton(
                      child: const Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if(formattedTime == null || formattedDate == null){
                          return;
                        }
                        context.read<AddEventBloc>().add(AddStartTimeEvent(startTime: formattedTime, date: formattedDate));

                      },
                    ),
                  ],
                ),
              ),
            ).whenComplete(() {
              context.read<AddEventBloc>().add(TimeErrorEvent());
            });
            break;

          case StatusTime.endTime:
            var formattedTime;
          // `startTime`ni bo'lib, soat va daqiqa qiymatlarini ajratamiz
            final time = state.startTime?.split(":");
            final int startHour = int.tryParse(time?.first ?? "0") ?? 0;
            final int startMinute = int.tryParse(time?.last ?? "0") ?? 0;

            showCupertinoModalPopup(
              context: context,
              builder: (_) => Container(
                height: MediaQuery.of(context).size.height * 0.3,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        initialDateTime: DateTime(
                          2024, 1, 1, startHour, startMinute + 1,
                        ), // EndTime tanlash uchun `startTime`dan keyin boshlanadi
                        minimumDate: DateTime(
                          2024, 1, 1, startHour, startMinute ,
                        ), // EndTime `startTime`dan keyin tanlanishi kerak
                        use24hFormat: true,
                        onDateTimeChanged: (DateTime value) {
                          formattedTime = TimeOfDay(
                            hour: value.hour,
                            minute: value.minute,
                          ).format(context);

                        },
                      ),
                    ),
                    CupertinoButton(
                      child: const Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if(formattedTime == null){
                          return;
                        }
                        context.read<AddEventBloc>().add(AddEndTimeEvent(endTime: formattedTime));
                      },
                    ),
                  ],
                ),
              ),
            ).whenComplete(() {
              context.read<AddEventBloc>().add(TimeErrorEvent());
            });
            break;

          case StatusTime.finish:
            timeController.text = "${state.startTime?.toString()} - ${state.endTime?.toString()}";
            break;
        }

      },
      builder: (context, state) {
        return CommonScaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: context.colors.systemBlack,
              ),
              onPressed: () {
                context.read<CalendarPageBloc>().add(LoadEventsEvent());

                Navigator.pop(context,null);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  CommonText(text: 'Event name'),
                  CommonTextField(
                      controller: titleController,
                      onChanged: (text) {
                    context.read<AddEventBloc>().add(AddTitleEvent(title: text));
                  }),
                  SizedBox(height: 20),
                  CommonText(text: 'Event description'),
                  CommonTextField(
                    controller: descriptionController,
                      description: true,
                      onChanged: (text) {
                        context.read<AddEventBloc>().add(AddDescriptionEvent(description: text));

                        if (kDebugMode) {
                          print(text);
                        }
                      }),
                  SizedBox(height: 20),
                  CommonText(text: 'Event Location'),
                  CommonTextField(
                    controller: locationController,
                      icon: Icons.location_on,
                      onChanged: (text) {
                        context.read<AddEventBloc>().add(AddLocationEvent(location: text));

                        if (kDebugMode) {
                          print(text);
                        }
                      }),
                  CommonText(text: "Priority color"),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.colors.systemGrey),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          color: Color(state.color ?? state.calenderModel?.color ?? colors[0].value),
                        ),
                        // SizedBox(width: 5,),
                        PopupMenuButton<int>(
                          onSelected: (T) {
                            context.read<AddEventBloc>().add(AddColorEvent(color: T));

                            isSelect = T;
                          },
                          initialValue: state.color ?? state.calenderModel?.color ?? colors[0].value,
                          color: context.colors.onPrimary2,
                          // offset: Offset(0, 100),
                          icon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: context.colors.primary,
                            size: 35,
                          ),
                          itemBuilder: (BuildContext context) {
                            return [
                              for (int i = 0; i <= colors.length - 1; i++)
                                PopupMenuItem(
                                    padding: EdgeInsets.zero,
                                    value: colors[i].value,
                                    child: Container(
                                      height: 10,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Color(colors[i].value), borderRadius: BorderRadius.circular(12)),
                                    ))
                            ];
                          },
                        ),
                      ],
                    ),
                  ),
                  CommonText(text: "Event Time"),

                  GestureDetector(
                    onTap: () {
                      context.read<AddEventBloc>().add(TimeEvent());
                    },
                    child: BlocBuilder<AddEventBloc, AddEventState>(
                      builder: (context, state) {
                        if(state.statusTime == StatusTime.finish){
                          timeController.text = "${state.startTime?.toString()} - ${state.endTime?.toString()}";
                        }
                        return CommonTextField(
                            controller: timeController,
                            enabled: false, onChanged: (text) {
                          // context.read<AddEventBloc>().add(AddTimeEvent(time: text));

                          if (kDebugMode) {
                            print(text);
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery
                        .sizeOf(context)
                        .height * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<AddEventBloc>().add(SaveButtonEvent());
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(color: context.colors.primary, borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: CommonText(
                            text: state.calenderModel != null ? "Save" : "Add",
                            color: context.colors.systemGrey,

                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
