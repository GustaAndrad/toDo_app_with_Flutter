import 'package:todo_list_provider/app/repositories/user/tasks/tasks_repository.dart';

import './tasks_service.dart';

class TasksServiceImpl implements TasksService {
  final TasksRepository _tasksRepository;

  TasksServiceImpl({
    required TasksRepository tasksRepository,
  }) : _tasksRepository = tasksRepository;

  @override
  Future<void> save(DateTime date, String description) =>
      _tasksRepository.save(date, description);
}
