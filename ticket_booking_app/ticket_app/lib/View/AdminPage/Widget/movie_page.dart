

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';


import 'showMovie.dart';

class MyMovie extends StatefulWidget {
  const MyMovie({super.key});

  @override
  State<MyMovie> createState() => _MyMovieState();
}

class _MyMovieState extends State<MyMovie> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        backgroundColor: const Color(0xFF1E192B),
          body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Container(
              //color: Colors.red,
              //width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              child: const Expanded(child: ShowMovie()),

            ),

        ]
        ),
    )
    );
  }
}
