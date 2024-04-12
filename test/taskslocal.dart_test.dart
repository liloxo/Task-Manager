import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/core/class/statusrequest.dart';
import 'package:task_manager/data/model/tasks/taskmodel.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class TaskDataLocal {
  Either<StatusRequest, List<TaskModel>?>? getTasks(
      String key, SharedPreferences sharedPreferences) {
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

void main() {
  late TaskDataLocal taskslocalData;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences =
        MockSharedPreferences(); // Initialize mock SharedPreferences
    taskslocalData = TaskDataLocal();
  });

  test('gettasks-Locally', () {
    // Arrange
    when(mockSharedPreferences.getStringList('tasks'))
        .thenReturn(['{"id":1,"todo":"todo 1","completed":false}']);
    // Act
    final response = taskslocalData.getTasks(
        'tasks', mockSharedPreferences); // Pass mock SharedPreferences
    // Assert
    expect(response, isA<Right<StatusRequest, List<TaskModel>?>>());
  });
}
