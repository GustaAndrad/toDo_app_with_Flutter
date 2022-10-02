import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class Task extends StatelessWidget {
  const Task({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.primaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.primaryColorLight.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          leading: Checkbox(
            value: true,
            onChanged: (value) {},
          ),
          title: Text(
            'Descrição da task',
            style: TextStyle(
              color: Colors.white,
              decoration: false ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            '20/09/2022',
            style: TextStyle(
              color: Colors.grey,
              decoration: false ? TextDecoration.lineThrough : null,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
