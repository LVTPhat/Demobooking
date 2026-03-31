
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/View/DetailPage/detail_page.dart';
import 'package:ticket_app/ViewModel/BloC/CheckOutBloc/checkout_bloc.dart';
import 'package:ticket_app/ViewModel/BloC/MovieBloc/movie_bloc.dart';
import 'package:ticket_app/ViewModel/BloC/MovieBloc/movie_event.dart';
import 'package:ticket_app/ViewModel/BloC/MovieBloc/movie_state.dart';
import 'package:ticket_app/ViewModel/service_request.dart';

import '../../../Model/movie_model.dart';


class MovieWidget extends StatefulWidget {


  const MovieWidget({super.key});
  @override
  State<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TODO: implement didChangeDependencies
    context.read<MovieBloc>().add(MovieFetch());

  }


  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 13, left: 10,top: 10),
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: Row(
    
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Movie",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white
                ),
              ),
               InkWell(
                 onTap: (){},
                 child: const Text(
                  "View all",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.yellow
                  ),
                               ),
               ),
            ],
          ),
        ),
    
        Container(
          width: MediaQuery.of(context).size.width,
          height: 290,
         // color: Colors.red,
          child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state){
                if (state is MovieLoading) {
                  print("MovieLoading");
                  return const Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is MovieFail) {
                  print("MovieFail");
                  final movieFailState = state;
                  return Center(
                    child: Text(movieFailState.message.toString()),
                  );
                } else if (state is MovieLoaded) {
                  final movieLoaded = state;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movieLoaded.movies.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyDetailPage(
                                myMovie: movieLoaded.movies[index],
                              ),
                            ),
                          );
                        },
                        child: mainMovie(movieLoaded.movies[index]),
                      );
                    },
                  );
                } else {
                  print("default");
                  return const Center(
                    child: Text("Unknown state"),
                  );
                }
              }
          )
        )
      ],
    );
  }
  Widget mainMovie(MovieModel movie){
    //print('${movie.title} - ${movie.favourite}');
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          //fit: StackFit.expand,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, top: 7, right: 3),
              width: 150,
              height: 220,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage('${ServiceRequest.baseURL}${movie.imageasset}'),
                      fit: BoxFit.cover
                  )
              ),
            ),

          ]
        ),
        Container(
          padding: EdgeInsets.only(left: 5,top: 5),
          width: 150,
         // color: Colors.green,
          child: Text(
              movie.title.toString(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
                color: Colors.white
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: 5),
          width: 150,
          height: 15,
        //  color: Colors.green,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index){
                if(index < movie.favourite!.toInt()){
                  return const Icon(Icons.star, color: Colors.yellow, size: 15,);
                }
                return const Icon(Icons.star, size: 15,color: Colors.white24,);
              }
          )
        ),
      ],
      
      
    );
  }

}
