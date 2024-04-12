import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/core/class/statusrequest.dart';
import 'package:task_manager/core/functions/checkinternet.dart';

class Crud {
  Future<Either<StatusRequest, Map>?> postData(
      String linkurl, Map data, bool putORpost) async {
    if (await checkInternet()) {
      var response = putORpost
          ? await http.post(
              Uri.parse(linkurl),
              body: data,
            )
          : await http.put(
              Uri.parse(linkurl),
              body: data,
            );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);
        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}

class CrudGet {
  Future<Either<StatusRequest, Map>?> getData(String linkurl) async {
    if (await checkInternet()) {
      var response = await http.get(
        Uri.parse(linkurl),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);
        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}

class CrudDelete {
  Future<Either<StatusRequest, Map>?> deleteData(String linkurl) async {
    if (await checkInternet()) {
      var response = await http.delete(
        Uri.parse(linkurl),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);
        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}
