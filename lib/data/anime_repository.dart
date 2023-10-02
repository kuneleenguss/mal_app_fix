import 'dart:io';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'open_mal_api.dart';
import 'model.dart';

class AnimeRepository {

  final OpenMalApi _api = OpenMalApi();

  Future<List<Anime>> getAnimeBySearch(String queue) async {
    final response = await http.get(_api.getUri(queue));
    final List<dynamic> parsedResult = jsonDecode(response.body)["data"];

    final List<Anime> animeList = List.generate(
        parsedResult.length, 
        (index) => Anime.fromJson(parsedResult[index])
      );

    return animeList;
  }
}