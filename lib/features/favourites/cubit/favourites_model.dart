import 'dart:async';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:mal_app_fix/data/anime_repository.dart';
import 'package:mal_app_fix/data/model.dart';
import 'package:provider/provider.dart';

class FavouritesModel extends ChangeNotifier {
  final _box = Hive.box<Anime>("anime_list");

  List<Anime?> get animeList => List.generate(_box.length, (index) => _box.getAt(index)); 

  void removeAnimeFromFavourites (int index) {
    _box.deleteAt(index);
    print(_box.length);
    notifyListeners();
  }
}