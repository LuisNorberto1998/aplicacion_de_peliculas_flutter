import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:app_movies/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = 'ea73a881966d7058b09361b6540026f2';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';

  Future<List<Pelicula>> getEncines() async {
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key': _apiKey, 
      'languaje': _languaje
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }
}
