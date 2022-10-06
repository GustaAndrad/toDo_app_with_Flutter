import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_task_model.dart';

class CardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTaskModel? totalTasksModel;
  final bool selected;

  const CardFilter({
    Key? key,
    required this.label,
    required this.taskFilter,
    required this.selected,
    this.totalTasksModel,
  }) : super(key: key);

  double _getPercentFinish() {
    final total = totalTasksModel?.totalTasks ?? 0.0;
    final totalFinish = totalTasksModel?.totalTasksFinish ?? 0.1;

    if (total == 0) {
      return 0.0;
    }

    final percent = (totalFinish * 100) / total;
    return percent / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 120,
        maxWidth: 150,
      ),
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: selected ? Colors.transparent : Colors.transparent,
        boxShadow: selected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2,
                  offset: Offset(1, 0),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 0,
                  offset: Offset(0, 0),
                ),
              ],
        border: selected
            ? Border.all(
                width: 1,
                color: Colors.purple.withOpacity(.5),
              )
            : Border.all(width: 1, color: Colors.black12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${totalTasksModel?.totalTasks ?? 0} TASKS',
            style: context.titleStyleHome.copyWith(
              fontSize: 10,
              color: selected ? Colors.white : Colors.white60,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: selected ? Colors.white : Colors.white60,
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(
              begin: 0.0,
              end: _getPercentFinish(),
            ),
            duration: Duration(seconds: 1),
            builder: (context, value, child) {
              return LinearProgressIndicator(
                backgroundColor: selected
                    ? Colors.purple.withOpacity(0.3)
                    : Colors.purple.withOpacity(0.1),
                valueColor: selected
                    ? AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 109, 255, 255),
                      )
                    : AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(109, 255, 255, 0.4),
                      ),
                value: value,
              );
            },
          ),
        ],
      ),
    );
  }
}
