import 'package:dio/dio.dart';

import '../../core/constant.dart';
import '../module/login_model.dart';

abstract class ApiService {
  Future<Login> login(String email, String password);
}

class ApiServiceImpl extends ApiService {
  Dio dio;

  ApiServiceImpl(this.dio);

  @override
  Future<Login> login(String email, String password) async {
    try {
      Map<String, String> params = {};
      params['email_id'] = email;
      params['password'] = password;
      final response = await dio.post(
        "$host$loginEp",
        data: params,
      );
      Login loginResponse = Login.fromJson(response.data);
      print("Api Response login : ${loginResponse.toString()}");
      return loginResponse;
    } on Exception catch (error) {
      return Login.fromJson(getErrorMap("Http Error"));
    }
  }

  Map<String, dynamic> getErrorMap(String errorMessage) {
    return {"error": true,"message": errorMessage,"data":null};
  }
}