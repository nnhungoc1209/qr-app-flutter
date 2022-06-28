class LoginModel {
  String? status;
  String? message;
  //User? user;

  LoginModel({this.status, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    //user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    // if (user != null) {
    //   data['user'] = user!.toJson();
    // }
    return data;
  }
}