import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hophseeflutter/data/module/doctor_login_model.dart';
import 'package:hophseeflutter/data/module/doctor_model.dart';

import '../../core/constant.dart';
import '../module/user_login_model.dart';
import '../module/response_query.dart';
import '../module/user_model.dart';

abstract class ApiService {
  Future<UserLogin> loginUser(String email, String password);

  Future<DoctorLogin> loginDoctor(String email, String password);

  Future<ResponseQuery> registerUser(User user, File file);

  Future<DoctorList> getDoctorList();

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
      print("File Path ${file.path} file name : $fileName");
      String userName = user.userName ?? "";
      String emailId = user.emailId ?? "";
      String phoneNo = user.phoneNo ?? "";
      String password = user.password ?? "";
      String gender = user.gender ?? "";
      String dateOfBirth = user.dateOfBirth ?? "";
      bool isDoctor = false;
      bool isActive =true;
      FormData formData = FormData.fromMap({
        "image_url":
            await MultipartFile.fromFile(file.path, filename: fileName),
        "user_name": userName,
        "email_id": emailId,
        "phone_no": phoneNo,
        "password": password,
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "is_doctor": isDoctor,
        "is_active": isActive
      });
      print("formdata : ${formData.fields}");
    final response = await dio.post(
        userEp,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      ResponseQuery registerUserResponse =
          ResponseQuery.fromJson(response.data);
      print("Api Response login : ${registerUserResponse.toString()}");
      return registerUserResponse;
    } on Exception catch (error) {
      return ResponseQuery.fromJson(getErrorMap("Http Error"));
    }
  }

  @override
  Future<DoctorList> getDoctorList() async{
    try {
      final response = await dio.get(
        doctorEp,
      );
      DoctorList doctorsResponse = DoctorList.fromJson(response.data);
      return doctorsResponse;
    } on Exception catch (error) {
      return DoctorList.fromJson(getErrorMap("Http Error"));
    }
  }
}
