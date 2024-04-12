part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class GetTasks extends TasksEvent {}

class GetRandomTask extends TasksEvent {}

class GetTaskById extends TasksEvent {}

class GetTasksPagination extends TasksEvent {}

class AddTask extends TasksEvent {
  final String task;

  const AddTask({
    required this.task,
  });
}

class EditTask extends TasksEvent {
  final String task;
  final bool completed;
  final int id;

  const EditTask(
      {required this.task, required this.completed, required this.id});
}

class DeleteTask extends TasksEvent {
  final int id;

  const DeleteTask({required this.id});
}
