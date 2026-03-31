

import 'package:ticket_app/Model/users_model.dart';

class ResponseModel{
  int status;
  String message;
  UsersModel? users;
  ResponseModel({required this.status,required this.message, this.users});

  factory ResponseModel.fromJson(Map<String, dynamic> json){
    return ResponseModel(
      status: json['status'],
      message: json['message'],
      users: json['users'] != null ? UsersModel.fromjson(json['users']) : null,
    );
  }
}