

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app/ViewModel/BloC/AuthBloc/auth_event.dart';
import 'package:ticket_app/ViewModel/BloC/AuthBloc/auth_state.dart';
import 'package:bloc/bloc.dart';
import 'package:ticket_app/ViewModel/repository.dart';
import 'package:ticket_app/ViewModel/service_request.dart';

import '../../../Model/response_model.dart';
import '../../../View/HomePage/home_page.dart';
import '../../utill.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<AuthLoginStarted>(_onLoginStarted);
    on<AuthRegisterStarted>(_onRegisterStarted);
  }
  final ServiceRequest repository;
  void _onLoginStarted(AuthLoginStarted event, Emitter<AuthState> emit) async {
    // Phát tín hiệu quá trình đang diễn ra
    emit(AuthLoginInProgress());

    // Bỏ qua bước gọi API loginUser và điều hướng trực tiếp đến HomePage
    Navigator.push(
        event.context,
        MaterialPageRoute(builder: (context) => const HomePage())
    );

    // Nếu muốn hiện một thông báo thành công (tùy chọn)
    Utill.showSimpleDialog(event.context, "Đăng nhập thành công!");
  }
  void _onRegisterStarted(AuthRegisterStarted event, Emitter<AuthState> emit) async{
    emit(AuthLoginInProgress());
    ResponseModel res = await repository.registerUser(event.username, event.password, event.repassword);
    if(res != null){
      Utill.showSimpleDialog(event.context, res.message.toString());
    }
    else{
      Utill.showSimpleDialog(event.context, "Có lỗi xảy ra");
    }

  }
}