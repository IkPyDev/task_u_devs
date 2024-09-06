import 'package:flutter/material.dart';
import 'package:task_u_devs/core/extension/color.dart';
import 'package:task_u_devs/core/extension/time.dart';
import 'package:task_u_devs/shared/domain/model/calender_model.dart';

import '../../../../core/widgets/common_text.dart';
import '../../../../core/widgets/common_text_icon_button.dart';

class ItemEvent extends StatelessWidget {
  final Function? onTap;

  CalendarModel? calenderModel;
   ItemEvent({this.onTap,this.calenderModel,super.key});

  @override
  Widget build(BuildContext context) {
    final color = calenderModel?.color ?? 0xFFFFFFFF;
    return GestureDetector(
      onTap:onTap != null ? () => onTap!() : null,
      child: Container(
        decoration:
            BoxDecoration(color: Color(color).withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              // color: context.colors.redSelect,
              height: 10,
              decoration: BoxDecoration(
                  color: Color(color),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  CommonText(
                    text: calenderModel?.title ??"",
                    color: context.transFormColors(Color(color)),
                    fontWeight: FontWeight.bold,
                    textSize: 22,
                    padding: 0,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CommonText(
                    text: calenderModel?.description ?? "",
                    color: context.transFormColors(Color(color)),
                    textSize: 14,
                    padding: 0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      children: [
                        CommonTextIconButton(
                          backgroundColor: Color(color).withOpacity(0),
                          title: "${calenderModel?.startTime} - ${calenderModel?.endTime}",
                          color:  Color(color),
                          iconData: Icons.timer_rounded,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                       if(calenderModel?.location == null)
                         CommonTextIconButton(
                          backgroundColor: Color(calenderModel?.color??0xFFFFFFFF).withOpacity(0),
                          title: calenderModel?.location ?? "",
                          color: Color(calenderModel?.color??0xFFFFFFFF),
                          iconData: Icons.location_on,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
