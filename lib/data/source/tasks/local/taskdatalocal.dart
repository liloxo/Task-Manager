import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:task_manager/core/class/statusrequest.dart';
import 'package:task_manager/data/model/tasks/taskmodel.dart';
import 'package:task_manager/main.dart';

class TaskdataLocal {
  Either<StatusRequest, List<TaskModel>?>? getTasks(String key) {
    List<String>? tasksJson = sharedPreferences.getStringList(key);
    if (tasksJson != null) {
      List<TaskModel>? tasksModel = tasksJson
          .map((json) => TaskModel.fromJson(jsonDecode(json)))
          .toList();
      return Right(tasksModel);
    } else {
      return const Left(StatusRequest.failure);
    }
  }
}

class TaskslocalData {
  TaskdataLocal taskdataLocal;
  TaskslocalData(this.taskdataLocal);
  gettasks() {
    var response = taskdataLocal.getTasks('tasks');
    return response!.fold((l) => l, (r) => r);
  }

  getRandom() {
    var response = taskdataLocal.getTasks('randomtask');
    return response!.fold((l) => l, (r) => r);
  }

  getTaskbyid() {
    var response = taskdataLocal.getTasks('taskid');
    return response!.fold((l) => l, (r) => r);
  }
}
