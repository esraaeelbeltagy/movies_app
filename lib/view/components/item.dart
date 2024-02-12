// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/movies_model.dart';

// ignore: must_be_immutable
class Item extends StatelessWidget {
  MovieModel movie;
  Item({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.white, width: .5),
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  movie.backdropPath,
                  fit: BoxFit.cover,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/error.png');
                  },
                ),
              )
              //Image.asset('assets/images/error.png'),
              ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  movie.overview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      CupertinoIcons.bookmark,
                      color: Color(0xffDEE4E7),
                      size: 25,
                    ),
                    SizedBox(width: 5,),
                    Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
