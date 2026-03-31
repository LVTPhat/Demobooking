

import 'package:flutter/cupertino.dart';
import 'package:ticket_app/Model/users_model.dart';

class AuthEvent{}


class AuthLoginStarted extends AuthEvent{
  UsersModel? user;
  final String username;
  final String password;
  BuildContext context;
  AuthLoginStarted({this.user, required this.context, required this.username,required this.password});
}

class AuthRegisterStarted extends AuthEvent{
  final String username;
  final String password;
  final String repassword;
  BuildContext context;
  AuthRegisterStarted({required this.context, required this.username,required this.password, required this.repassword});

}

