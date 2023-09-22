import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hophseeflutter/data/module/doctor_login_model.dart';

import '../../core/constant.dart';
import '../module/user_login_model.dart';
import '../module/response_query.dart';
import '../module/user_model.dart';

abstract class ApiService {
  Future<UserLogin> loginUser(String email, String password);

  Future<DoctorLogin> loginDoctor(String email, String password);

  Future<ResponseQuery> registerUser(User user, File file);
}

class ApiServiceImpl extends ApiService {
  Dio dio;

  ApiServiceImpl(this.dio);

  @override
  Future<UserLogin> loginUser(String email, String password) async {
    try {
      Map<String, String> params = {};
      params['email_id'] = email;
      params['password'] = password;
      final response = await dio.post(
        loginUserEp,
        data: params,
      );
      UserLogin loginResponse = UserLogin.fromJson(response.data);
      print("Api Response login : ${loginResponse.toString()}");
      return loginResponse;
    } on Exception catch (error) {
      return UserLogin.fromJson(getErrorMap("Http Error"));
    }
  }

  @override
  Future<DoctorLogin> loginDoctor(String email, String password) async {
    try {
      Map<String, String> params = {};
      params['email_id'] = email;
      params['password'] = password;
      final response = await dio.post(
        loginDoctorEp,
        data: params,
      );
      DoctorLogin loginResponse = DoctorLogin.fromJson(response.data);
      print("Api Response login : ${loginResponse.toString()}");
      return loginResponse;
    } on Exception catch (error) {
      return DoctorLogin.fromJson(getErrorMap("Http Error"));
    }
  }

  Map<String, dynamic> getErrorMap(String errorMessage) {
    return {"error": true, "message": errorMessage, "data": null};
  }

  @override
  Future<ResponseQuery> registerUser(User user, File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image_url":
            await MultipartFile.fromFile(file.path, filename: fileName),
        "user_name": user.userName,
        "email_id": user.emailId,
        "phone_no": user.phoneNo,
        "password": user.password,
        "gender": user.gender,
        "date_of_birth": user.dateOfBirth,
        "is_doctor": user.isDoctor,
        "is_active": user.isActive
      });
      print("formdata : $formData");
      final response = await dio.post(
        "$host$userEp",
        data: formData,
      );
      ResponseQuery registerUserResponse =
          ResponseQuery.fromJson(response.data);
      print("Api Response login : ${registerUserResponse.toString()}");
      return registerUserResponse;
    } on Exception catch (error) {
      return ResponseQuery.fromJson(getErrorMap("Http Error"));
    }
  }
}
