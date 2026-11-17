import 'dart:convert';

import 'package:movies_app/models/models.dart';

class nowPopularsMovie {
    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    nowPopularsMovie({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory nowPopularsMovie.fromJson(String str) => nowPopularsMovie.fromMap(json.decode(str));

    // String toJson() => json.encode(toMap());

    factory nowPopularsMovie.fromMap(Map<String, dynamic> json) => nowPopularsMovie(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    /* Map<String, dynamic> toMap() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
    }; */
}
