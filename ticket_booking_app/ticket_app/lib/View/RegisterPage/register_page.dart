

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/View/RegisterPage/widget/register_widget.dart';
import 'package:ticket_app/ViewModel/BloC/AuthBloc/auth_bloc.dart';


import '../../ViewModel/service_request.dart';

class RegisterPage extends StatefulWidget {


  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor: Color(0xFF1E192B),
        body: RegisterWidget(),

    );
  }
}
