


import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ticket_app/View/DetailPage/Widget/info2_movie_widget.dart';

import '../../Model/movie_model.dart';
import '../../ViewModel/service_request.dart';
import 'Widget/content_button.dart';
import 'Widget/info_movie_widget.dart';

class MyDetailPage extends StatefulWidget {
  final MovieModel myMovie;
  const MyDetailPage({super.key, required this.myMovie});

  @override
  State<MyDetailPage> createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {

  @override
  Widget build(BuildContext context) {
    if (widget.myMovie == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Page Null'),
        ),
        body: const Center(
          child: Text('Giá trị rỗng'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFF1E192B),
      body: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('${ServiceRequest.baseURL}${widget.myMovie.imagebanner}'),
                          fit: BoxFit.cover
                      ),
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  Positioned(
                    left: 15,
                      top: 30,
                      child: InkWell(
                        onTap: (){
                        Navigator.pop(context);
                        }, child: Container(
                        width: 30,
                          height: 30,
                          //color: Colors.red,
                          child: const Icon(
                              Icons.arrow_back, color:  Colors.white, size: 28,),
                        )
                      )
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.23,
                    child: Container(
                      width: 150,
                      height: 210,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage('${ServiceRequest.baseURL}${widget.myMovie.imageasset}'),
                          fit: BoxFit.cover
                        ),
                        shape: BoxShape.rectangle
                      ),

                    ),
                  ),
                  Positioned(
                     left: MediaQuery.of(context).size.width * 0.45,
                      top: MediaQuery.of(context).size.height * 0.30,
                      child: InfoMovieWidget(myMovie: widget.myMovie,)
                  ),
                  Positioned(

                    top: MediaQuery.of(context).size.height * 0.51,
                    child: Container(
                      width: MediaQuery.of(context).size.width,

                      //color: Colors.green,
                      child: Info2MovieWidget(myMovie: widget.myMovie,)
                    ),

                  ),

                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.61,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        //color: Colors.red,
                        alignment: Alignment.center,
                        child: const Text(
                            "Description",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.66,
                      child: MyDescription(myMovie: widget.myMovie,)

                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}



