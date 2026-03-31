


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_app/Model/movie_model.dart';
import 'package:ticket_app/ViewModel/BloC/MovieBloc/movie_event.dart';
import 'package:ticket_app/ViewModel/BloC/MovieBloc/movie_state.dart';

import '../../../Model/response_model.dart';
import '../../service_request.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState>{
  MovieBloc({required this.serviceRepository}) : super(MovieInitial()){
    on<MovieFetch>(_onFetchMovie);
    on<AddMovie>((event, emit) async{
        ResponseModel res = await serviceRepository.addMovie(event.data, event.imageAssets, event.imageBanner);
        if(res != null){
          ScaffoldMessenger.of(event.context).showSnackBar(
            SnackBar(
              content: Text(
                res.message,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }
        else{
          ScaffoldMessenger.of(event.context).showSnackBar(
            SnackBar(
              content: Text(
                res.message,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.yellowAccent,
              duration: const Duration(seconds: 2),
            ),
          );
        }

    });
    on<EditMovie>((event, emit) async{
      ResponseModel res = await serviceRepository.editMovie(event.data, event.imageAsset, event.imageBanner);
      if(res != null){
        ScaffoldMessenger.of(event.context).showSnackBar(
          SnackBar(
            content: Text(
              res.message,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),

          ),

        );
        await Future.delayed(Duration(seconds: 2));

      }
      else{
        ScaffoldMessenger.of(event.context).showSnackBar(
          SnackBar(
            content: Text(
              res.message,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.yellowAccent,
            duration: const Duration(seconds: 2),
          ),
        );

      }
    });
    on<DeleteMovie>((event, emit) async{
      ResponseModel res = await serviceRepository.deleteMovie(event.id);
      if(res != null){
        ScaffoldMessenger.of(event.context).showSnackBar(
          SnackBar(
            content: Text(
              res.message,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
        await Future.delayed(Duration(seconds: 2));
        event.context.read<MovieBloc>().add(MovieFetch());
      }else{
        ScaffoldMessenger.of(event.context).showSnackBar(
          SnackBar(
            content: Text(
              res.message,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.yellowAccent,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }
  final ServiceRequest serviceRepository;
  void _onFetchMovie(MovieEvent event, Emitter<MovieState> emit) async{
    emit(MovieLoading());
    List<MovieModel> data = await serviceRepository.fetchMovies();
    if (data.isNotEmpty) {
      emit(MovieLoaded(data));
    } else {
      emit(MovieFail("Không tìm thấy Movie"));
    }
  }

}