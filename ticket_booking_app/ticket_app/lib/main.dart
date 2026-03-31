import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_app/View/LoginPage/login_page.dart';
import 'package:ticket_app/ViewModel/BloC/AuthBloc/auth_bloc.dart';
import 'package:ticket_app/ViewModel/service_request.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        repository: ServiceRequest(),
      ),
      child: const MaterialApp(
        home: SafeArea(
          child: Scaffold(
            body: LoginPage(),
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
