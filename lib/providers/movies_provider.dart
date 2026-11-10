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

  MoviesProvider() {
    print('Movies provider inicializado');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');

    var url =
        Uri.https(_baseUrl, "3/movie/now_playing", {'api_key': _apiKey, 'language': _language, 'page': _page});

    final result = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

    OnDisplayMovie = nowPlayingResponse.Movies;
  }
}
