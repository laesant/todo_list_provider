import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>(
          (controller) => controller.selectedFilter == TaskFilter.week),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text('DIA DA SEMANA', style: context.titleStyle),
          const SizedBox(height: 10),
          SizedBox(
              height: 95,
              child: Selector<HomeController, DateTime>(
                selector: (_, controller) =>
                    controller.initialDateOfWeek ?? DateTime.now(),
                builder: (_, value, __) {
                  return DatePicker(
                    value,
                    locale: 'pt_BR',
                    initialSelectedDate: value,
                    selectionColor: context.primaryColor,
                    selectedTextColor: Colors.white,
                    daysCount: 7,
                    onDateChange: (date) {
                      context.read<HomeController>().filterByDay(date);
                    },
                  );
                },
              ))
        ],
      ),
    );
  }
}
