part of 'tasks_bloc.dart';

sealed class TasksState {
  const TasksState();
}

final class TasksInitial extends TasksState {}

final class TasksLoading extends TasksState {}

final class TasksFailure extends TasksState {
  final String error;

  const TasksFailure({required this.error});
}

final class TasksSuccess extends TasksState {
  final List<TaskModel>? tasksModel;
  final bool pagination;
  final String? message;
  const TasksSuccess({
    this.tasksModel,
    this.pagination = false,
    this.message,
  });
}

final class ExcutionFailed extends TasksState {
  final String error;

  const ExcutionFailed({required this.error});
}

final class ExcutionSucceed extends TasksState {
  final String message;

  const ExcutionSucceed({required this.message});
}
