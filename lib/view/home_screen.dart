// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:movies_app_with_api/view_model/cubit/movies_cubit.dart';

import 'components/item.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesCubit()..getData(),
      child: Scaffold(
        drawer: const Drawer(
          backgroundColor: Colors.black,
          shadowColor: Color(0xffDEE4E7),
          width: 310,
        ),
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Movies App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //* this is the body of the app
        body: BlocConsumer<MoviesCubit, MoviesState>(
          buildWhen: (previous, current) {
            return current is! MoviesGetLoadingFromPaginationState &&
                current is! MoviesGetFaildFromPaginationState;
          },
          listener: (context, state) {},
          builder: (context, state) {
            print(state);
            MoviesCubit cubit = MoviesCubit.get(context);

            if (state is MoviesGetLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (state is MoviesGetFaildState) {
              return Center(
                child: Text(state.error,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              );
            } else if (state is MoviesGetSucessState) {
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  print('scrolling');
                  if (notification.metrics.pixels ==
                          notification.metrics.maxScrollExtent &&
                      notification is ScrollUpdateNotification) {
                    cubit.getData(fromPagination: true);
                    print('loading ');
                  }
                  return true;
                },
                child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) =>
                        Item(movie: state.list[index]),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10.0,
                        ),
                    itemCount: state.list.length),
              );
            } else {
              return const Center(
                child: Text(
                  "Unknown state",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          },
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: BlocBuilder<MoviesCubit, MoviesState>(
            buildWhen: (previous, current) {
              return current is MoviesGetLoadingFromPaginationState ||
                  current is MoviesGetFaildFromPaginationState ||
                  current is MoviesGetSucessState;
            },
            builder: (context, state) {
              if (state is MoviesGetLoadingFromPaginationState) {
                return const SizedBox(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
              } else if (state is MoviesGetFaildFromPaginationState) {
                return Center(
                  child: Text(
                    state.error,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
