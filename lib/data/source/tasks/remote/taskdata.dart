import 'package:task_manager/core/class/crud.dart';
import 'package:task_manager/core/constants/apilinks.dart';

class TaskData {
  CrudGet? crudget;
  Crud? crud;
  CrudDelete? crudDelete;
  TaskData(this.crudget, this.crud, this.crudDelete);

  getdata(int limit, int skip) async {
    var response = await crudget!
        .getData('https://dummyjson.com/todos?limit=$limit&skip=$skip');
    return response!.fold((l) => l, (r) => r);
  }

  getTasksbyid(int id) async {
    var response =
        await crudget!.getData('https://dummyjson.com/todos/user/$id');
    return response!.fold((l) => l, (r) => r);
  }

  getRandomtask() async {
    var response = await crudget!.getData(ApiLink.randomtask);
    return response!.fold((l) => l, (r) => r);
  }

  addData(String task, String userid) async {
    var response = await crud!.postData(ApiLink.addtask,
        {'todo': task, 'completed': 'false', 'userId': userid}, true);
    return response!.fold((l) => l, (r) => r);
  }

  updateData(String task, bool iscomplete, int taskId) async {
    var response = await crud!.postData('https://dummyjson.com/todos/$taskId',
        {'todo': task, 'completed': iscomplete.toString()}, false);

    return response!.fold((l) => l, (r) => r);
  }

  deleteData(int taskId) async {
    var response =
        await crudDelete!.deleteData('https://dummyjson.com/todos/$taskId');
    return response!.fold((l) => l, (r) => r);
  }
}
