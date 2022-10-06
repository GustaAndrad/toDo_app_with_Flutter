import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_task_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/widgets/card_filter.dart';

class HomeFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILTROS',
          style: context.titleStyleHome,
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CardFilter(
                label: 'HOJE',
                taskFilter: TaskFilterEnum.today,
                totalTasksModel: TotalTaskModel(
                  totalTasks: 5,
                  totalTasksFinish: 5,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.today,
              ),
              CardFilter(
                label: 'AMANHÃ',
                taskFilter: TaskFilterEnum.tomorrow,
                totalTasksModel: TotalTaskModel(
                  totalTasks: 10,
                  totalTasksFinish: 5,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.tomorrow,
              ),
              CardFilter(
                label: 'SEMANA',
                taskFilter: TaskFilterEnum.week,
                totalTasksModel: TotalTaskModel(
                  totalTasks: 10,
                  totalTasksFinish: 5,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.week,
              ),
            ],
          ),
        )
      ],
    );
  }
}
