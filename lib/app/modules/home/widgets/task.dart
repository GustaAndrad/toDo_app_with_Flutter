import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/yyyy');
  Task({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _buildConfirmDismiss(context),
      onDismissed: (_) async {
        await context.read<HomeController>().deleteTask(model);
        Messages.of(context).showInfo('Task Deletada com sucesso');
      },
      background: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 185, 47, 38).withOpacity(0.8),
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
        child: Icon(
          Icons.delete_forever_outlined,
          size: 40,
          shadows: [
            BoxShadow(
              color: Colors.red.withOpacity(0.8),
              blurRadius: 5,
              offset: Offset(2, 2),
            ),
          ],
        ),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(vertical: 5),
      ),
      child: Container(
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
              value: model.finished,
              onChanged: (value) =>
                  context.read<HomeController>().checkOrUncheckTask(model),
            ),
            title: Text(
              model.description,
              style: TextStyle(
                color: Colors.white,
                decoration: model.finished ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              dateFormat.format(model.dateTime),
              style: TextStyle(
                color: Colors.grey,
                decoration: model.finished ? TextDecoration.lineThrough : null,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _buildConfirmDismiss(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.black26,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text('Excluir!'),
          titleTextStyle: TextStyle(color: Colors.white),
          content: Text(
            'Confirma a exclusão da Task ?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
