import 'package:task_manager/core/class/statusrequest.dart';

checkstatus(var res, String reason) {
  if (res == StatusRequest.offlinefailure) {
    return 'No Internet Connection ';
  } else if (res == StatusRequest.serverfailure) {
    return reason;
  } else if (res == StatusRequest.serverexception) {
    return 'Server Error';
  }
}
