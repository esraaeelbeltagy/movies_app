class MoviesModel {
  late final int page;
  late final List<MovieModel> results;

  
  late final int totalPages;
  late final int totalResults;

  MoviesModel({
    required this.page,
    required this.results ,
    required this.totalPages ,
    required this.totalResults,
  });

  MoviesModel.fromJson(Map<String,dynamic> json){
    page = json["page"];
    results = List.from(json["results"]).map((e) => MovieModel.fromJson(e)).toList();

    //? results is a list , so to convert map to a list we us >> List.from(json["Results"])
    //! but to convert it to our model we should map/loop on it and return convert 




  totalPages = json["total_pages"];
  totalResults = json["total_results"];
  }
}

class MovieModel {
  late final bool adult;
  late final String backdropPath;
  late final int id;
  late final String originalLanguage;
  late final String originalTitle;
  late final String overview;
  late final double popularity;
  late final String posterPath;
  late final String releaseDate;
  late final String title;
  late final bool video;
  late final double voteAverage;
  late final int voteCount;

  MovieModel({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  MovieModel.fromJson(Map<String, dynamic> map) {
    adult = map["adult"];
    backdropPath = "http://image.tmdb.org/t/p/original${map["backdrop_path"]}" ;
    id = map["id"];
    originalLanguage = map["original_language"];
    originalTitle = map["original_title"];
    overview = map["overview"];
    popularity = double.parse(map["popularity"].toString());
    posterPath = map["poster_path"];
    releaseDate = map["release_date"];
    title = map["title"];
    video = map["video"];
    voteAverage = double.parse(map["vote_average"].toString());
    voteCount = map["vote_count"];
  }
}



   