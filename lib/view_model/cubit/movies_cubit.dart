import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/movies_model.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesInitial());

  static MoviesCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  final List<MovieModel> _movies = [];
  int pageNumber = 1;

  void getData({bool fromPagination = false}) async {
    if (fromPagination) {
      emit(MoviesGetLoadingFromPaginationState());
    } else {
      emit(MoviesGetLoadingState());
    }

    try {
      var response = await Dio().get(
          "https://api.themoviedb.org/3/movie/now_playing?api_key=a674e3861f0ebf3d4563910dbabfbda5&page=$pageNumber");

      var listOfMovies = MoviesModel.fromJson(response.data);
      if (listOfMovies.results.isNotEmpty) {
        pageNumber++;
        _movies.addAll((listOfMovies.results).toList());
      }

      emit(MoviesGetSucessState(list: _movies));
    } on DioException catch (e) {
      if (fromPagination) {
        emit(MoviesGetFaildFromPaginationState(error: e.toString()));
      } else {
        emit(MoviesGetFaildState(error: e.toString()));
      }
    }
  }
}
