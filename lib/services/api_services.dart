import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie.dart';

class APIservices {
  static const String apiKey = "7103d8a268722a02858a2c416bbf7762";
  static const String baseUrl = "https://api.themoviedb.org/3";

  Future<List<Movie>> _getMovies(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint?api_key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((movie) => Movie.fromMap(movie)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<String?> getMovieTrailer(String movieTitle) async {
    try {
      final searchUrl = Uri.parse(
        '$baseUrl/search/movie?api_key=$apiKey&query=${Uri.encodeComponent(movieTitle)}',
      );
      final searchResponse = await http.get(searchUrl);
      
      if (searchResponse.statusCode == 200) {
        final searchData = json.decode(searchResponse.body);
        if (searchData['results'].isEmpty) return null;
        
        final movieId = searchData['results'][0]['id'];
        final videosUrl = Uri.parse(
          '$baseUrl/movie/$movieId/videos?api_key=$apiKey',
        );
        final videosResponse = await http.get(videosUrl);
        
        if (videosResponse.statusCode == 200) {
          final videosData = json.decode(videosResponse.body);
          final trailers = (videosData['results'] as List).where(
            (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
          );
          if (trailers.isNotEmpty) {
            return trailers.first['key'];
          }
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Movie>> getNowShowing() => _getMovies('/movie/now_playing');
  Future<List<Movie>> getUpComing() => _getMovies('/movie/upcoming');
  Future<List<Movie>> getPopular() => _getMovies('/movie/popular');
  
  Future<List<Movie>> getMoviesByCategory(String category) async {
    if (category == 'All') {
      return getNowShowing();
    }
    final url = Uri.parse(
      '$baseUrl/discover/movie?api_key=$apiKey&with_genres=${_getCategoryId(category)}',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((movie) => Movie.fromMap(movie)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  String _getCategoryId(String category) {
    switch (category) {
      case 'Action':
        return '28';
      case 'Comedy':
        return '35';
      case 'Romance':
        return '10749';
      case 'Horror':
        return '27';
      default:
        return '';
    }
  }



  Future<List<Movie>> searchMovies(String query) async {
  final url = Uri.parse(
    '$baseUrl/search/movie?api_key=$apiKey&query=${Uri.encodeComponent(query)}',
  );
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['results'];
    return data.map((movie) => Movie.fromMap(movie)).toList();
  } else {
    throw Exception("Failed to load search results");
  }
}

}