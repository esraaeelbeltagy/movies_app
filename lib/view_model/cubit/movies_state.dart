part of 'movies_cubit.dart';

sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

final class MoviesGetLoadingState extends MoviesState {}

final class MoviesGetSucessState extends MoviesState {
  final List<MovieModel> list;
  MoviesGetSucessState({required this.list});
}

final class MoviesGetFaildState extends MoviesState {
  String error;

  MoviesGetFaildState({required this.error}); 
}

//* for pagination
final class MoviesGetLoadingFromPaginationState extends MoviesState {}

final class MoviesGetSucessFromPaginationState extends MoviesState {}

final class MoviesGetFaildFromPaginationState extends MoviesState {
  final String error;
  MoviesGetFaildFromPaginationState({required this.error});
}
