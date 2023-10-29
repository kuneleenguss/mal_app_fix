import 'dart:async';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:mal_app_fix/data/anime_repository.dart';
import 'package:mal_app_fix/data/model.dart';
import 'package:provider/provider.dart';

class SearchModel extends ChangeNotifier {
  final AnimeRepository _animeRepository = AnimeRepository();
  List<Anime> animeList = [];
  final _box = Hive.box<Anime>("anime_list");

  Future<void> getAnimeBySearch(String queue) async {
    animeList = await _animeRepository.getAnimeBySearch(queue);
    notifyListeners();
  }

  void addAnimeToFavourites (Anime anime) {
    (_box.values.contains(anime)) 
    ? null 
    : _box.add(anime);
    // print(box.getAt(0));
    print(_box.length);
    notifyListeners();
  }

  bool isFavourite (Anime anime) { 
    return _box.values.contains(anime);    
  }
}