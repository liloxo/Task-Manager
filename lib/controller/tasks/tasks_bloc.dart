import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/core/class/crud.dart';
import 'package:task_manager/core/class/statusrequest.dart';
import 'package:task_manager/core/functions/checkstatus.dart';
import 'package:task_manager/core/functions/handlingstatus.dart';
import 'package:task_manager/data/model/tasks/taskmodel.dart';
import 'package:task_manager/data/source/tasks/local/taskdatalocal.dart';
import 'package:task_manager/data/source/tasks/remote/taskdata.dart';
import 'package:task_manager/main.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TaskData taskData = TaskData(CrudGet(), Crud(), CrudDelete());
  TaskslocalData taskdataLocal = TaskslocalData(TaskdataLocal());
  List<TaskModel>? tasksModel = [];
  int skip = 0;
  bool forpagination = true;
  TasksBloc() : super(TasksInitial()) {
    on<GetTasks>(_getTasks);
    on<GetRandomTask>(_getRandomtask);
    on<GetTaskById>(_getTaskbyid);
    on<GetTasksPagination>(_getTaskspagination);
    on<AddTask>(_addTasks);
    on<EditTask>(_editTasks);
    on<DeleteTask>(_deleteTasks);
  }

  _getTaskspagination(TasksEvent event, Emitter<TasksState> emit) async {
    emit(TasksSuccess(tasksModel: tasksModel, pagination: true));
    var response = await taskData.getdata(10, skip);
    var res = handlingData(response);
    if (res == StatusRequest.offlinefailure) {
      emit(const ExcutionFailed(error: 'No Internet Connection'));
      emit(TasksSuccess(tasksModel: tasksModel, pagination: false));
    }
    if (res == StatusRequest.success) {
      List newtasks = response['todos'];
      List<TaskModel>? tasks =
          newtasks.map((e) => TaskModel.fromJson(e)).toList();

      tasksModel?.addAll(tasks);
      skip = skip + 10;
      emit(TasksSuccess(tasksModel: tasksModel, pagination: false));
      return;
    } else {
      emit(
          TasksFailure(error: checkstatus(response, "Something's went wrong")));
    }
  }

  _getTaskbyid(TasksEvent event, Emitter<TasksState> emit) async {
    skip = 0;
    emit(TasksLoading());
    int userid = sharedPreferences.getInt('userid')!;
    var response = await taskData.getTasksbyid(userid);
    var res = handlingData(response);
    if (res == StatusRequest.offlinefailure) {
      var localresponse = taskdataLocal.gettasks();
      if (localresponse == StatusRequest.failure) {
        emit(const TasksFailure(error: 'No data found'));
      } else {
        emit(TasksSuccess(tasksModel: localresponse));
      }
      return;
    }
    if (res == StatusRequest.success) {
      List tasks = response['todos'];
      tasksModel = tasks.map((e) => TaskModel.fromJson(e)).toList();
      List<String> tasksJson =
          tasksModel!.map((task) => jsonEncode(task.toJson())).toList();
      await sharedPreferences.setStringList('taskid', tasksJson);
      emit(TasksSuccess(tasksModel: tasksModel));
      return;
    } else {
      emit(
          TasksFailure(error: checkstatus(response, "Something's went wrong")));
    }
  }

  _getRandomtask(TasksEvent event, Emitter<TasksState> emit) async {
    skip = 0;
    emit(TasksLoading());
    var response = await taskData.getRandomtask();
    var res = handlingData(response);
    if (res == StatusRequest.offlinefailure) {
      var localresponse = taskdataLocal.gettasks();
      if (localresponse == StatusRequest.failure) {
        emit(const TasksFailure(error: 'No data found'));
      } else {
        emit(TasksSuccess(tasksModel: localresponse));
      }
      return;
    }
    if (res == StatusRequest.success) {
      List tasks = [response];
      tasksModel = tasks.map((e) => TaskModel.fromJson(e)).toList();
      List<String> tasksJson =
          tasksModel!.map((task) => jsonEncode(task.toJson())).toList();
      await sharedPreferences.setStringList('randomtask', tasksJson);
      emit(TasksSuccess(tasksModel: tasksModel));
      return;
    } else {
      emit(
          TasksFailure(error: checkstatus(response, "Something's went wrong")));
    }
  }

  _getTasks(GetTasks event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    var response = await taskData.getdata(10, skip);
    var res = handlingData(response);
    if (res == StatusRequest.offlinefailure) {
      var localresponse = taskdataLocal.gettasks();
      if (localresponse == StatusRequest.failure) {
        emit(const TasksFailure(error: 'No data found'));
      } else {
        emit(TasksSuccess(tasksModel: localresponse));
      }
      return;
    }
    if (res == StatusRequest.success) {
      List tasks = response['todos'];
      tasksModel = tasks.map((e) => TaskModel.fromJson(e)).toList();
      List<String> tasksJson =
          tasksModel!.map((task) => jsonEncode(task.toJson())).toList();
      await sharedPreferences.setStringList('tasks', tasksJson);
      skip = skip + 10;
      emit(TasksSuccess(tasksModel: tasksModel));
      return;
    } else {
      emit(
          TasksFailure(error: checkstatus(response, "Something's went wrong")));
    }
  }

  _addTasks(AddTask event, Emitter<TasksState> emit) async {
    int userid = sharedPreferences.getInt('userid')!;
    var response = await taskData.addData(event.task, userid.toString());
    var res = handlingData(response);
    if (res == StatusRequest.success) {
      TaskModel editedTask = TaskModel(
        id: response['id'],
        todo: response['todo'],
        completed: "${response['completed']}" == 'true' ? true : false,
        userId: int.parse(response['userId']),
      );
      tasksModel!.insert(0, editedTask);

      emit(const ExcutionSucceed(message: 'Task Added Successfully'));
      emit(TasksSuccess(tasksModel: tasksModel));
    } else {
      emit(ExcutionFailed(error: checkstatus(response, 'Adding Task Failed')));
    }
  }

  _editTasks(EditTask event, Emitter<TasksState> emit) async {
    if (event.id == 151) {
      int userid = sharedPreferences.getInt('userid')!;
      TaskModel editedTask = TaskModel(
        id: event.id,
        todo: event.task,
        completed: event.completed,
        userId: userid,
      );
      int index = tasksModel!.indexWhere((task) => task.id == editedTask.id);
      tasksModel![index] = editedTask;
      emit(const ExcutionSucceed(message: 'Task Edited Successfully'));
      emit(TasksSuccess(tasksModel: tasksModel));
      return;
    }
    var response =
        await taskData.updateData(event.task, event.completed, event.id);
    var res = handlingData(response);
    if (res == StatusRequest.success) {
      TaskModel editedTask = TaskModel(
        id: response['id'],
        todo: response['todo'],
        completed: response['completed'] == 'true' ? true : false,
        userId: response['userId'],
      );
      int index = tasksModel!.indexWhere((task) => task.id == editedTask.id);
      tasksModel![index] = editedTask;
      emit(const ExcutionSucceed(message: 'Task Edited Successfully'));
      emit(TasksSuccess(tasksModel: tasksModel));
    } else {
      emit(ExcutionFailed(error: checkstatus(response, 'Editing Task Failed')));
    }
  }

  _deleteTasks(DeleteTask event, Emitter<TasksState> emit) async {
    if (event.id == 151) {
      tasksModel!.removeWhere((element) => element.id == event.id);
      emit(const ExcutionSucceed(message: 'Task Deleted Successfully'));
      emit(TasksSuccess(tasksModel: tasksModel));
      return;
    }
    var response = await taskData.deleteData(event.id);
    var res = handlingData(response);
    if (res == StatusRequest.success) {
      tasksModel!.removeWhere((element) => element.id == event.id);
      emit(const ExcutionSucceed(message: 'Task Deleted Successfully'));
      emit(TasksSuccess(tasksModel: tasksModel));
    } else {
      emit(
          ExcutionFailed(error: checkstatus(response, 'Deleting Task Failed')));
    }
  }
}
