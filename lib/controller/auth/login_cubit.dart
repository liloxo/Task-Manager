import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/core/class/crud.dart';
import 'package:task_manager/core/class/statusrequest.dart';
import 'package:task_manager/core/functions/checkstatus.dart';
import 'package:task_manager/core/functions/handlingstatus.dart';
import 'package:task_manager/data/source/auth/remote/logindata.dart';
import 'package:task_manager/main.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginData loginData = LoginData(Crud());
  LoginCubit() : super(LoginInitial());

  login(String? username, String? password) async {
    emit(LoginLoading());
    var response = await loginData.postdata(username!, password!);
    var res = handlingData(response);
    if (res == StatusRequest.success) {
      await sharedPreferences.setBool('signed', true);
      await sharedPreferences.setInt('userid', response['id']);
      await sharedPreferences.setString('username', response['username']);
      emit(LoginSuccess());
    } else {
      emit(LoginFailure(
          error: checkstatus(response, 'Username or Password is Incorrect')));
    }
  }
}
