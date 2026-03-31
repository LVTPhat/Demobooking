

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/View/LoginPage/widget/login_widget.dart';
import 'package:ticket_app/ViewModel/BloC/AuthBloc/auth_bloc.dart';
import 'package:ticket_app/ViewModel/repository.dart';
import 'package:ticket_app/ViewModel/service_request.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1E192B),
      body: LoginWidget(),
    );
  }
}
