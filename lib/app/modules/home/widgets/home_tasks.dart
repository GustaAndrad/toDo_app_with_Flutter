import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/home/widgets/task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'TASK\'S DE HOJE',
                style: context.titleStyleHome,
              ),
              Column(
                children: [
                  Task(),
                  Task(),
                  Task(),
                  Task(),
                  Task(),
                  Task(),
                  Task(),
                  Task(),
                  Task(),
                  Task(),
                  Task(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
