

import '../../../Model/movie_model.dart';

abstract class MovieState{}

class MovieInitial extends MovieState{}
class MovieLoading extends MovieState{}
class MovieSuccess extends MovieState{}
class MovieLoaded extends MovieState{
  final List<MovieModel> movies;
  MovieLoaded(this.movies);
}
class MovieFail extends MovieState{
  final String message;
  MovieFail(this.message);
}
