import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';

class CalendarButton extends StatelessWidget {
  final dateFormat = DateFormat('dd/MM/yyyy');

  CalendarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var lasDate = DateTime.now();
        lasDate = lasDate.add(Duration(days: 5 * 365));

        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: lasDate,
        );

        context.read<TaskCreateController>().selectedDate = selectedDate;
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white54,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.today,
              color: Colors.white70,
            ),
            SizedBox(width: 5),
            Selector<TaskCreateController, DateTime?>(
              selector: (context, controller) => controller.selectedDate,
              builder: (context, selectedDate, child) {
                if (selectedDate != null) {
                  return Text(
                    dateFormat.format(selectedDate),
                    style: context.titleStyle
                        .copyWith(fontSize: 12, color: Colors.white60),
                  );
                } else {
                  return Text(
                    'SELECIONA UMA DATA',
                    style: context.titleStyle
                        .copyWith(fontSize: 12, color: Colors.white60),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
