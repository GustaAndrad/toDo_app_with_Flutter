import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_page.dart';
import 'package:todo_list_provider/app/repositories/user/tasks/tasks_repository.dart';
import 'package:todo_list_provider/app/repositories/user/tasks/tasks_repository_impl.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service_impl.dart';

class TasksModule extends TodoListModule {
  TasksModule()
      : super(
          routers: {
            '/task/create': ((context) => TaskCreatePage(
                  controller: context.read(),
                )),
          },
          bindings: [
            Provider<TasksRepository>(
              create: (context) => TasksRepositoryImpl(
                sqliteConnectionFactory: context.read(),
              ),
            ),
            Provider<TasksService>(
              create: (context) => TasksServiceImpl(
                tasksRepository: context.read(),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  TaskCreateController(tasksService: context.read()),
            )
          ],
        );
}
