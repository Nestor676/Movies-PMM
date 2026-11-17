import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = "api.themoviedb.org";
  String _apiKey = "0f37cfbaba24d31035e2ae10b4ef38fd";
  String _language = "es-ES";
  String _page = "1";

  List<Movie> OnDisplayMovie = [];
  List<Movie> PopularsMovie = [];

  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    print('Movies provider inicializado');
    this.getOnDisplayMovies();
    this.getPopularsMovie();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');

    try {
      var url = Uri.https(_baseUrl, "3/movie/now_playing",
          {'api_key': _apiKey, 'language': _language, 'page': _page});

      print('URL: $url');

      final result = await http.get(url);

      print('Código HTTP: ${result.statusCode}');
      print('Respuesta: ${result.body}');

      final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

      OnDisplayMovie = nowPlayingResponse.Movies;

      print('Películas recibidas: ${OnDisplayMovie.length}');

      notifyListeners();
    } catch (e, stackTrace) {
      print('ERROR: $e');
      print(stackTrace);
    }
  }

  getPopularsMovie() async {
    print('getPopularsMovie');

    try{
      var url = Uri.https(_baseUrl, "3/movie/popular",
        {'api_key' : _apiKey, 'language' : _language, 'page' : _page});
      

      final result = await http.get(url);

      final popularsMovie = nowPopularsMovie.fromJson(result.body);

      PopularsMovie = popularsMovie.results;

      print('Películas recibidas: ${PopularsMovie.length}');

      notifyListeners();
    }catch(e, stackTrace){
      print('ERROR: $e');
      print(stackTrace);
    }
  }

  Future<List<Cast>> getMovieCast(int idMovie) async {
    print('Pedimos info al servidor');

    var url = Uri.https(_baseUrl, "3/movie/$idMovie/credits",
      {'api_key' : _apiKey, 'language' : _language});
      

    final result = await http.get(url);

    final creditsResponse = CreditsResponse.fromJson(result.body);

    casting[idMovie] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
