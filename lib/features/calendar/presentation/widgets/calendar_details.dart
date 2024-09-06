import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_u_devs/features/detail_event/presentation/detail_event_page.dart';

import '../../../../core/widgets/common_text.dart';
import '../../../detail_event/presentation/bloc/detail_event_bloc.dart';
import '../bloc/calendar_page_bloc.dart';
import '../bloc/calendar_page_event.dart';
import '../bloc/calendar_page_state.dart';
import 'item_event.dart';

class CalendarDetails extends StatelessWidget {
  const CalendarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarPageBloc, CalendarPageState>(
      builder: (context, state) {
        if (state.status == Status.success) {
          return Expanded(
              child: ListView.separated(
                  itemBuilder: (_, i) => ItemEvent(
                        onTap: () {
                          // context.read<CalendarPageBloc>().add(SelectedDayOpenEvent(state.selectList[i].id ?? 0 ));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => BlocProvider(
                                        create: (context) =>
                                            DetailEventBloc()..add(DetailLoadEvent(state.selectList[i].id ?? 0)),
                                        child: const DetailEventPage(),
                                      ),),).then((value) {
                            context.read<CalendarPageBloc>().add(LoadEventsEvent());
                          });
                        },
                        calenderModel: state.selectList[i],
                      ),
                  separatorBuilder: (_, __) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: state.selectList.length));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
