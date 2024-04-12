import 'package:task_manager/core/class/crud.dart';

import '../../../../core/constants/apilinks.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);

  postdata(String username, String password) async {
    var response = await crud.postData(
        ApiLink.login, {"username": username, "password": password}, true);
    return response!.fold((l) => l, (r) => r);
  }
}
