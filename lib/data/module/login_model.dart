class Login {
  int? error;
  String? message;
  Data? data;

  Login({this.error, this.message, this.data});

  Login.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  @override
  String toString() {
    return 'Login{error: $error, message: $message, data: ${data.toString()}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? user;
  int? userId;
  String? lastLogin;

  Data({this.user, this.userId, this.lastLogin});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    userId = json['user_id'];
    lastLogin = json['last_login'];
  }

  @override
  String toString() {
    return 'Data{user: $user, userId: $userId, lastLogin: $lastLogin}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['user_id'] = this.userId;
    data['last_login'] = this.lastLogin;
    return data;
  }
}

